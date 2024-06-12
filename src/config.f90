module config
   character(len=:), allocatable :: output_directory
   real :: sim_time_minutes, save_lapse_minutes

contains
      subroutine init_config(sim_time, save_lapse, directory)
      !! Initializes the configuration for the simulation.
      character(len=*), intent(in) :: directory
      real, intent(in) :: sim_time !! simulation time in minutes
      real, intent(in) :: save_lapse !! save lapse in minutes
      sim_time_minutes = sim_time
      save_lapse_minutes = save_lapse
      output_directory = directory
      call create_directory(output_directory)
   end subroutine init_config

   subroutine create_directory(directory)
      character(len=*), intent(in) :: directory
      call system("mkdir " // directory)
   end subroutine create_directory
end module config
