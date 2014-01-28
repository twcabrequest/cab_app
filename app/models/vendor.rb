# -*- encoding : utf-8 -*-
class Vendor < ActiveRecord::Base
  attr_accessible :name, :contact_no, :email, :order

  validates_uniqueness_of :name, :email
  validates_presence_of :name, :contact_no, :email, :order
  validates_numericality_of :order, only_integer: true
  validates_numericality_of :contact_no, only_integer: true
  validates_length_of :contact_no, is: 10
  validates_format_of :name, with: /^[a-zA-Z\s]*$/
end


