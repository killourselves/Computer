
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name MyComputer -dir "C:/Users/HASEE/Desktop/yanjy/Computer/MyComputer/planAhead_run_2" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/HASEE/Desktop/yanjy/Computer/MyComputer/mycpu.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/HASEE/Desktop/yanjy/Computer/MyComputer} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "mycpu.ucf" [current_fileset -constrset]
add_files [list {mycpu.ucf}] -fileset [get_property constrset [current_run]]
link_design
