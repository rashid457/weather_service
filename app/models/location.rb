# frozen_string_literal: true

class Location < ApplicationRecord
  validates :name, presence: true
  validates :condition, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
end
