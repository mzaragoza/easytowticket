class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string   :identification,                             default: ''
      t.integer  :account_id
      t.integer  :created_by_id
      t.integer  :requested_by_id
      t.integer  :driver_id
      t.integer  :truck_id
      t.string   :location_of_viecle,                         default: ''
      t.string   :name,                                       default: ''
      t.string   :phone,                                      default: ''
      t.string   :address,                                    default: ''
      t.string   :address2,                                   default: ''
      t.string   :city,                                       default: ''
      t.string   :state,                                      default: ''
      t.string   :zip,                                        default: ''
      t.string   :license_number,                             default: ''
      t.integer  :milleage_finish
      t.integer  :milleage_start
      t.datetime :service_time_finish
      t.datetime :service_time_start
      t.datetime :extra_truck_finish
      t.datetime :extra_truck_start
      t.string   :car_year,                                   default: ''
      t.string   :car_make,                                   default: ''
      t.string   :car_model,                                  default: ''
      t.string   :car_color,                                  default: ''
      t.string   :vin_number,                                 default: ''
      t.string   :tag_number,                                 default: ''
      t.string   :tow_destination,                            default: ''
      t.string   :operators_comments,                         default: ''
      t.string   :status,                                     default: ''
      t.decimal  :milleage_charge
      t.decimal  :towing_charge
      t.decimal  :labor_charge
      t.decimal  :storage_charge
      t.decimal  :administration_fee
      t.decimal  :tax
      t.boolean  :sling,                                      :null => false, default: false
      t.boolean  :hoist_tow,                                  :null => false, default: false
      t.boolean  :wheel_lift,                                 :null => false, default: false
      t.boolean  :flad_bed,                                   :null => false, default: false
      t.boolean  :start,                                      :null => false, default: false
      t.boolean  :lock_out,                                   :null => false, default: false
      t.boolean  :flat_tire,                                  :null => false, default: false
      t.boolean  :out_of_gas,                                 :null => false, default: false
      t.boolean  :wreck,                                      :null => false, default: false
      t.boolean  :recovery,                                   :null => false, default: false
      t.string   :other,                                      default: ''
      t.boolean  :special_equipment_single_line_winching,     :null => false, default: false
      t.boolean  :special_equipment_dual_line_winching,       :null => false, default: false
      t.boolean  :special_equipment_snatch_blocks,            :null => false, default: false
      t.boolean  :special_equipment_scotch_blocks,            :null => false, default: false
      t.boolean  :special_equipment_dolly,                    :null => false, default: false
      t.string   :special_equipment_other,                    default: ''

      t.timestamps
    end
  end
end
