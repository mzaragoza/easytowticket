class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer  :account_id
      t.integer  :created_by_id
      t.string   :location_of_viecle,                         default: ''
      t.string   :name,                                       default: ''
      t.string   :phone,                                      default: ''
      t.string   :address,                                    default: ''
      t.string   :zip,                                        default: ''
      t.integer  :millage_finish
      t.integer  :millage_start
      t.datetime :servie_time_finish
      t.datetime :servie_time_start
      t.string   :extra_person_finish,                        default: ''
      t.string   :extra_person_start,                         default: ''
      t.string   :extra_person_total,                         default: ''
      t.string   :car_year,                                   default: ''
      t.string   :car_make,                                   default: ''
      t.string   :car_model,                                  default: ''
      t.string   :car_color,                                  default: ''
      t.string   :driver,                                     default: ''
      t.string   :state,                                      default: ''
      t.string   :license_number,                             default: ''
      t.string   :vehicle_id,                                 default: ''
      t.boolean  :sling,                                      :null => false, default: true
      t.boolean  :hoist_tow,                                  :null => false, default: false
      t.boolean  :wheel_lift,                                 :null => false, default: false
      t.boolean  :flad_bed,                                   :null => false, default: false
      t.boolean  :start,                                      :null => false, default: false
      t.boolean  :lock_out,                                   :null => false, default: false
      t.boolean  :flat_tire,                                  :null => false, default: false
      t.boolean  :out_of_gas,                                 :null => false, default: false
      t.boolean  :wreck,                                      :null => false, default: false
      t.boolean  :recoverty,                                  :null => false, default: false
      t.string   :other,                                      default: ''
      t.boolean  :special_equipment_single_line_winching,     :null => false, default: false
      t.boolean  :special_equipment_dual_line_winching,       :null => false, default: false
      t.boolean  :special_equipment_snatch_blocks,            :null => false, default: false
      t.boolean  :special_equipment_scotch_blocks,            :null => false, default: false
      t.boolean  :special_equipment_dolly,                    :null => false, default: false
      t.boolean  :special_equipment_other,                    :null => false, default: false
      t.string   :operators_comments,                         default: ''
      t.string   :status,                                     default: ''

      t.timestamps
    end
  end
end
