#!/usr/bin/env ruby

require 'json'

# Reads JSON documents from STDIN (one document per line) and
# replaces "special" tokens in keys as follows:
#
#  @         becomes   i_
#  http://   becomes   uhttp_
#  .         becomes   _
#  -         becomes   _
#  /         becomes   __
#  #         becomes   ___
#
# Required to make JSON work with Hive's OpenX-JSON SerDe.

def transform_key(key)
  key.sub(/^@/, 'i_').sub(/^http:\/\//, 'uhttp_').gsub(/[.-]/, '_').gsub('/', '__').gsub('#', '___')
end

def traverse(object)
  if object.kind_of?(Hash) then
    traverse_hash(object)
  elsif object.kind_of?(Array) then
    traverse_array(object)
  else
    object
  end
end

def traverse_hash(hash)
  safe = {}
  hash.each_pair { |key, value|
    safe[transform_key(key)] = traverse(value)
  }
  safe
end

def traverse_array(array)
  safe = []
  array.each { |object|
    safe << traverse(object)
  }
  safe
end

STDIN.each { |line|
  json = JSON.parse(line)
  safe = traverse_hash(json)
  puts JSON.generate(safe)
}

