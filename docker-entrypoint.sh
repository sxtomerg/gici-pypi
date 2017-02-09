#!/bin/bash
python /app/setup.py bdist_wheel
twine upload /app/dist/* -r private