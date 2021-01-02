#!/bin/bash

protoc --dart_out=grpc:lib/src/pb -I protos ./protos/*.proto
