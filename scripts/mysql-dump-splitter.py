#!/usr/bin/env python3
#
# Usage: mysql-dump-splitter.py dump.sql.gz
# Usage: mysql-dump-splitter.py dump.sql.bz2
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

import sys
import re
import gzip
import bz2


# HEADER_REGEX = r''
SECTION_INDICATOR = r'\n--\n-- (?P<description>[^\n]+)\n--\n'
SECTION_DATABASE = r'Current Database: `(?P<name>[^`]+)`'
SECTION_TABLE_STRUCTURE = r'Table structure for table `(?P<name>[^`]+)`'
SECTION_TABLE_DATA = r'Dumping data for table `(?P<name>[^`]+)`'
SECTION_TEMP_VIEW = r'Temporary table structure for view `(?P<name>[^`]+)`'
SECTION_FINAL_VIEW = r'Final view structure for view `(?P<name>[^`]+)`'
# SECTION_INDICATOR_FOOTER = r'UNLOCK TABLES;\n\/\*\!'

SECTION_TYPE_HEADER = 1
SECTION_TYPE_DATABASE = 2
SECTION_TYPE_TABLE_STRUCTURE = 3
SECTION_TYPE_TABLE_DATA = 4
SECTION_TYPE_TEMP_VIEW = 5
SECTION_TYPE_FINAL_VIEW = 6
SECTION_TYPE_FOOTER = 90
SECTION_TYPE_UNKNOWN = 99


def write_data_to_disk(file, section_type, section_name, data, excludes):
    stype = (
        'database' if section_type == SECTION_TYPE_DATABASE else
        'structure' if section_type == SECTION_TYPE_TABLE_STRUCTURE else
        'temp_view' if section_type == SECTION_TYPE_TEMP_VIEW else
        'final_view' if section_type == SECTION_TYPE_FINAL_VIEW else
        'data' if section_type != SECTION_TYPE_UNKNOWN else
        None
    )

    # Just skip unknown sections completely.
    if not stype:
        return file

    filename = '%s.%s.sql.gz' % (section_name, stype)

    if section_name in excludes and stype == 'data':
        # Make sure that we don't write to files we want to skip.
        if file is None or (type(file) is str and file != filename) or \
           (type(file) is not str and file.name != filename):
            file = filename
            print('Skipping file: %s' % filename)
        return file

    if file is None or type(file) is str or file.name != filename:
        print('Writing file: %s' % filename)
        file = gzip.open(filename, 'w')

    file.write(data)
    return file


def main(source_file, excludes):
    regex_indicator = re.compile(SECTION_INDICATOR, re.I | re.M)
    regex_database = re.compile(SECTION_DATABASE, re.I | re.M)
    regex_table_structure = re.compile(SECTION_TABLE_STRUCTURE, re.I | re.M)
    regex_table_data = re.compile(SECTION_TABLE_DATA, re.I | re.M)
    regex_temp_view = re.compile(SECTION_TEMP_VIEW, re.I | re.M)
    regex_final_view = re.compile(SECTION_FINAL_VIEW, re.I | re.M)
    # regex_footer = re.compile(SECTION_INDICATOR_FOOTER, re.I | re.M)

    cur_section_type = SECTION_TYPE_HEADER
    cur_section_name = 'header'
    cur_file = None

    if source_file.endswith('.sql.gz'):
        file = gzip.open(source_file, 'rb')
    elif source_file.endswith('.sql.bz2'):
        file = bz2.open(source_file, 'rb')
    elif source_file.endswith('.sql'):
        file = open(source_file, 'rb')
    else:
        raise Exception('Unknown file type. Filename can have the following endings: .sql, .sql.gz, .sql.bz2')

    buffer = ''
    last_lines = dict()
    footer = []
    for data in file:
        line = str(data, 'UTF-8', 'replace')

        if footer:
            match = regex_indicator.search(buffer + line)
            if not match:
                buffer += line
                footer.append(data)
                continue
            else:
                footer = []

        try:
            last_lines[0] = last_lines[1]
            last_lines[1] = line
        except KeyError:
            last_lines[0] = ''
            last_lines[1] = line

        if last_lines[0] == 'UNLOCK TABLES;\n' and line.startswith('/*!'):
            footer.append(data)
            continue

        if not line.startswith('--') and not line.strip() == '' and \
                cur_section_type:
            cur_file = write_data_to_disk(
                cur_file, cur_section_type, cur_section_name, data, excludes)
            buffer = ''
        buffer += line
        match = regex_indicator.search(buffer)
        if match:
            buffer = ''
            result = match.groupdict()

            description = result['description']
            database_result = regex_database.search(description)
            structure_result = regex_table_structure.search(description)
            data_result = regex_table_data.search(description)
            temp_view_result = regex_temp_view.search(description)
            final_view_result = regex_final_view.search(description)

            if database_result:
                cur_section_name = database_result.group('name')
                cur_section_type = SECTION_TYPE_DATABASE
            elif structure_result:
                cur_section_name = structure_result.group('name')
                cur_section_type = SECTION_TYPE_TABLE_STRUCTURE
            elif data_result:
                cur_section_name = data_result.group('name')
                cur_section_type = SECTION_TYPE_TABLE_DATA
            elif temp_view_result:
                cur_section_name = temp_view_result.group('name')
                cur_section_type = SECTION_TYPE_TEMP_VIEW
            elif final_view_result:
                cur_section_name = final_view_result.group('name')
                cur_section_type = SECTION_TYPE_FINAL_VIEW
            else:
                # raise Exception('Unknown section type: %s' % description)
                print('Unknown section type: %s' % description)
                cur_section_name = None
                cur_section_type = SECTION_TYPE_UNKNOWN

    cur_section_type = SECTION_TYPE_FOOTER
    cur_section_name = 'footer'
    for data in footer:
        cur_file = write_data_to_disk(
            cur_file, cur_section_type, cur_section_name, data, excludes)


if __name__ == '__main__':
    try:
        excludes = sys.argv[2].split(',')
    except IndexError:
        excludes = []
    main(sys.argv[1], excludes)
