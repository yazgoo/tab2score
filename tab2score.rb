#!/usr/bin/env ruby
#encoding: UTF-8
require 'awesome_print'
bases = {E: 0, A: 5, D: 10, G: 15}
notes = ['mi', 'fa', 'fa#', 'sol', 'sol#', 'la', 'sib', 'si', 'do', 'do#', 're', 'mib']
puts (["$", $0] + ARGV).join " "
delta = ARGV.size > 1 ? ARGV[1].to_i : 0
File.open(ARGV[0]) do |f|
    begin
    loop do
        puts f.readline
        mesures = [{}, {}, {}, {}, {}]
        4.times.collect do
            line = f.readline
            puts line
            line = line.split("|")
            note = bases[line.shift.to_sym]
            line.collect { |x| Hash[x.split("—").each_with_index.select { |y| not y[0].empty? }.collect { |a, b| [b, notes[(note + a.to_i + delta) % notes.size]] } ] }.each_with_index { |mesure, i| mesures[i].merge! mesure }
        end
        mesures[0..3].each { |mesure| print "#{Hash[mesure.sort_by{|k,v| k}].values.join " "}|" }
        puts
        2.times { puts f.readline }
    end
    rescue EOFError
    end
end
