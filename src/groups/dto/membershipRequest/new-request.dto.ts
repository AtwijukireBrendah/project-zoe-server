export class NewRequestDto {
  contactId: number;
  email: string;
  phone: string;
  churchLocation: number;
  residencePlaceId: string;
  residenceDescription: string;
}

export class GetClosestGroupDto {
  placeId: string;
  parentGroupId: number;
}

export class GetGroupResponseDto {
  groupId: number;
  groupName: string;
  groupMeta: string;
  distance: number;
}

export class GetMissingReportDto {
  startDate: string;
  endDate: string;
  parentGroupId: number;
}
