import 'package:equatable/equatable.dart';

class PageState extends Equatable{
  final int currentIndex;
  final int totalPages;

  const PageState({required this.currentIndex, required this.totalPages});
  
  @override
  List<Object?> get props => <Object?>[currentIndex,totalPages];
}