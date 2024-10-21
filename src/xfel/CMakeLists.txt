
add_library(xfel_mono_sim SHARED mono_simulation/bandpass_gaussian.cpp mono_simulation/ccixfel_core.cpp)
target_link_libraries(xfel_mono_sim PUBLIC CCTBX::scitbx CCTBX::rstbx CCTBX::annlib)

add_library(legacy_scale SHARED metrology/legacy_scale/scale_core.cpp metrology/legacy_scale/bandpass_gaussian.cpp)
target_link_libraries(legacy_scale PUBLIC CCTBX::annlib CCTBX::rstbx)

Python_add_library(acqiris_ext MODULE acqiris_ext.cpp)
target_link_libraries(acqiris_ext PRIVATE CCTBX::scitbx)

Python_add_library(sx_clustering_ext MODULE clustering/ext.cpp)
target_link_libraries(sx_clustering_ext PRIVATE CCTBX::scitbx)

Python_add_library(sx_merging_ext MODULE merging/ext.cpp)
target_link_libraries(sx_merging_ext PRIVATE CCTBX::scitbx)

Python_add_library(xfel_ext MODULE ext.cpp)
target_link_libraries(xfel_ext PRIVATE CCTBX::scitbx)

Python_add_library(xfel_legacy_scale_ext MODULE metrology/legacy_scale/ext.cpp)
target_link_libraries(xfel_legacy_scale_ext PRIVATE legacy_scale CCTBX::scitbx)

Python_add_library(xfel_metrology_ext MODULE metrology_ext.cpp)
target_link_libraries(xfel_metrology_ext PRIVATE CCTBX::scitbx)

Python_add_library(xfel_mono_sim_ext MODULE mono_simulation/ext.cpp)
target_link_libraries(xfel_mono_sim_ext PRIVATE xfel_mono_sim)

Python_add_library(xfel_sdfac_refine_ext MODULE merging/algorithms/error_model/sdfac_refine_ext.cpp)
target_link_libraries(xfel_sdfac_refine_ext PRIVATE DIALS::dials)

# fast_linalg is not included in cctbx-base
if(TARGET CCTBX::fast_linalg)
    Python_add_library(xes_ext MODULE vonHamos/xes_ext.cpp)
    target_link_libraries(xes_ext PRIVATE CCTBX::scitbx CCTBX::fast_linalg)
    install(TARGETS xes_ext DESTINATION "${Python_SITEARCH}")
endif()

install(TARGETS legacy_scale xfel_mono_sim)
install(
    TARGETS
    acqiris_ext
    sx_clustering_ext
    sx_merging_ext
    xfel_ext
    xfel_legacy_scale_ext
    xfel_metrology_ext
    xfel_mono_sim_ext
    xfel_sdfac_refine_ext
    DESTINATION "${Python_SITEARCH}"
)