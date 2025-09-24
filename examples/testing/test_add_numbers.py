#!/usr/bin/env python3

# Author: J.A.Boogaard@hr.nl

import unittest

def add_numbers(a, b):
    return a + b

class TestAddNumbers(unittest.TestCase):
    def test_add_numbers(self):
        result = add_numbers(3, 5)
        expected_value = 8
        self.assertEqual(result, expected_value)

if __name__ == '__main__':
    unittest.main()
