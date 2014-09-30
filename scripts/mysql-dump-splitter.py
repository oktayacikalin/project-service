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
SECTION_INDICATOR_FOOTER = r'UNLOCK TABLES;\n\/\*\!'

SECTION_TYPE_HEADER = 1
SECTION_TYPE_DATABASE = 2
SECTION_TYPE_TABLE_STRUCTURE = 3
SECTION_TYPE_TABLE_DATA = 4
SECTION_TYPE_FOOTER = 5
SECTION_TYPE_UNKNOWN = 99


def write_data_to_disk(file, section_type, section_name, data, excludes):
    stype = (
        'database' if section_type == SECTION_TYPE_DATABASE else
        'structure' if section_type == SECTION_TYPE_TABLE_STRUCTURE else
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
    regex_footer = re.compile(SECTION_INDICATOR_FOOTER, re.I | re.M)

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
            footer.append(data)
            continue

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

            if database_result:
                cur_section_name = database_result.group('name')
                cur_section_type = SECTION_TYPE_DATABASE
            elif structure_result:
                cur_section_name = structure_result.group('name')
                cur_section_type = SECTION_TYPE_TABLE_STRUCTURE
            elif data_result:
                cur_section_name = data_result.group('name')
                cur_section_type = SECTION_TYPE_TABLE_DATA
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
