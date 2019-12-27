
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name PmodCLS -dir "/home/ise/x/lcd/planAhead_run_4" -part xc6slx45csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/ise/x/lcd/PmodCLS_Demo.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/ise/x/lcd} }
set_property target_constrs_file "Nexys3_Master.ucf" [current_fileset -constrset]
add_files [list {Nexys3_Master.ucf}] -fileset [get_property constrset [current_run]]
link_design
