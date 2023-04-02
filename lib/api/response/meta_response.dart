import 'package:json_annotation/json_annotation.dart';

part 'meta_response.g.dart';

@JsonSerializable()
class MetaResponse {
  @JsonKey(name: "pagination")
  Pagination pagination;

  MetaResponse(this.pagination);

  factory MetaResponse.fromJson(dynamic json) => _$MetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MetaResponseToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "total")
  int total;
  @JsonKey(name: "per_page")
  int itemPerPage;
  @JsonKey(name: "current_page")
  int currentPage;
  @JsonKey(name: "total_pages")
  int totalPage;

  Pagination(this.total, this.itemPerPage, this.currentPage, this.totalPage);

  factory Pagination.fromJson(dynamic json) => _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}