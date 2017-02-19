#!/bin/bash
python /app/setup.py bdist_wheel --universal
twine upload /app/dist/* -r private
