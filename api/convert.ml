let to_program (program:Syobocal.program) =
  (
    {
      title = program.title;
      subtitle = program.subtitle;
      count = program.count;
      start_time = program.start_time;
      end_time = program.end_time;
    }
    :
    Api_t.program
  )