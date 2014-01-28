# -*- encoding : utf-8 -*-
require 'will_paginate/array'
class VendorsController < ApplicationController

  def index
    @vendors = Vendor.all.sort_by{|vendor| vendor.order}
  end

  def new
    @info = Vendor.new
  end

  def edit
    @info = Vendor.find(params[:id])
  end

  def create
    @info = Vendor.new(params[:vendor])
    @info.order = Vendor.all.count + 1
    if @info.save
      redirect_to vendors_path
    else
      render template: 'vendors/new'
    end

  end

  def update
    @info = Vendor.find(params[:id])

    if @info.update_attributes(params[:vendor])
      redirect_to vendors_path
    else
      render template: 'vendors/edit'
    end

  end

  def destroy
    @info = Vendor.find(params[:id])
    @info.destroy
    redirect_to vendors_path
  end

  def change_order_up
    @info = Vendor.where(id: params[:req]).first
    @info1 = Vendor.where(order: (@info.order - 1)).first
    @info.update_attribute(:order, @info1.order)
    @info1.update_attribute(:order, (@info1.order + 1))
    redirect_to vendors_path
  end

  def change_order_down
    @info = Vendor.where(id: params[:req]).first
    @info1 = Vendor.where(order: (@info.order + 1)).first
    @info.update_attribute(:order, @info1.order)
    @info1.update_attribute(:order, (@info1.order - 1))
    redirect_to vendors_path
  end

end
