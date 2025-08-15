// lib/bloc/delivery_orders_event.dart

import 'package:equatable/equatable.dart';

abstract class DeliveryOrdersEvent extends Equatable {
  const DeliveryOrdersEvent();

  @override
  List<Object> get props => [];
}

class FetchOrdersRequested extends DeliveryOrdersEvent {}
