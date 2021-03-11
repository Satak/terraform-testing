"""Script to test the external data provider in Terraform"""

import sys
import json
from os import path

DB_FILE_NAME = 'db.json'


def open_db(file_name):
    dn = path.dirname(path.realpath(__file__))
    fn = path.join(dn, file_name)

    with open(fn) as file:
        return json.load(file)


def get_product_name(product_id):
    db = open_db(DB_FILE_NAME)
    return next((product['name'] for product in db['data'] if product['id'] == product_id), None)


def read_in():
    return {x.strip() for x in sys.stdin}


def read_tf_input():
    return next(json.loads(line) for line in read_in() if line)


def write_tf_output(data):
    sys.stdout.write(json.dumps(data))


def main():
    tf_input = read_tf_input()
    product_name = get_product_name(tf_input['product_id'])
    output = product_name if product_name else f'No product found with id {tf_input["product_id"]}'

    output_data = {
        'output_key1': tf_input['input_param1'],
        'output_key2': tf_input['input_param2'],
        'output': output
    }
    write_tf_output(output_data)


if __name__ == '__main__':
    main()
