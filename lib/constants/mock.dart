import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/data/models/team.dart';

Currency dollar = Currency(name: 'доллары', rate: 91, amount: 10);
Currency euro = Currency(name: 'евро', rate: 96, amount: 20);
Currency pounds = Currency(name: 'фунты', rate: 116, amount: 30);

Team mockTeam = Team(
    name: 'FS',
    admin: 'Тимур',
    mainCurrencyName: 'рубли',
    mainCurrencySum: 11120,
    currencies: [dollar, euro, pounds],
    employees: mockEmployees);

List<Employee> mockEmployees = [
  Employee(
    name: "Тимур",
    advance: 0,
    hours: 0,
    image: "https://example.com/image1.jpg",
    percent: 1.0,
  ),
  Employee(
    name: "Арутик",
    advance: 0,
    hours: 0,
    image: "https://example.com/image2.jpg",
    percent: 1.0,
  ),
  Employee(
    name: "Стас",
    advance: 0,
    hours: 0,
    image: "https://example.com/image3.jpg",
    percent: 1.0,
  ),
  Employee(
    name: "Влад",
    advance: 0,
    hours: 0,
    image: "https://example.com/image4.jpg",
    percent: 1.0,
  ),
  Employee(
    name: "Саша",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
  ),
  Employee(
    name: "Денис",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
  ),
  Employee(
    name: "Илья",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
  ),
  Employee(
    name: "Руслан",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
  ),
  Employee(
    name: "Максим",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
  ),
];
