require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)

require 'app/player'
require 'app/index'
require 'app/game'
require 'app/grid'
require 'app/done'
require 'app/choices'

Game.perform

