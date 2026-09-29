# Thin wrapper over dbctl.py so `make <target>` works on Unix.
# Every target also works directly: `python dbctl.py <target>` (Windows-friendly).
PY ?= python3
FILE ?=
SQL ?=

.PHONY: help setup up down seed reset sql fetch test verify docs

help:
	@$(PY) dbctl.py --help

setup:
	@$(PY) dbctl.py setup

up:
	@$(PY) dbctl.py up

down:
	@$(PY) dbctl.py down

seed:
	@$(PY) dbctl.py seed

reset:
	@$(PY) dbctl.py reset

sql:
	@$(PY) dbctl.py sql --file "$(FILE)" --sql "$(SQL)"

fetch:
	@$(PY) dbctl.py fetch

test:
	@$(PY) dbctl.py test

verify:
	@$(PY) dbctl.py verify

docs:
	@$(PY) dbctl.py docs
