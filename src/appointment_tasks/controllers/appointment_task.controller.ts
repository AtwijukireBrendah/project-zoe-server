
import { Controller, Delete, Get, Param, Post, Put, Query, Body } from '@nestjs/common';
import { AppointmentTaskService } from '../appointment_task.service';
import SearchDto from '../../shared/dto/search.dto';
import { AppointmentTask } from '../entities/appointment_task.entity';
import { ApiTags } from '@nestjs/swagger';
import { getRepository } from 'typeorm';
import { Task } from 'src/tasks/task.entity';
import { Appointment } from 'src/appointment/entities/appointment.entity';
// import { TaskDto } from 'src/auth/dto/task.dto';
// import { CreateTaskDto } from 'src/auth/dto/create-task.dto';
@ApiTags("AppointmentTask")
@Controller('api/appointment-task')
export class AppointmentTaskController {
    constructor(private readonly service: AppointmentTaskService) {
    }

    @Get()
    async findAll(@Query() req): Promise<AppointmentTask[]> {
        return this.service.findAll(req);
    }
    @Post()
    async create(@Body() data: AppointmentTask): Promise<AppointmentTask> {
        return this.service.create(data);
    }

    
  @Get('assignedTasks')
  async findTheAssignedTasks() {

    const assignedTasks = await getRepository(Task)
      .createQueryBuilder("task")
      .leftJoinAndSelect("task.appointments", "appointment")
      .innerJoinAndMapOne("task.appointmentTask", AppointmentTask, "appointmentTask", "task.id = appointmentTask.taskId")
      .innerJoinAndMapMany("task.app", Appointment, "app", "appointmentTask.appointmentId = app.id")
      // .where("groupMembership.role = :role", { role: "Volunteer" })
      .getMany();

      
     

      return assignedTasks;
  }

}


