import 'package:flutter_tips_app/data/models/currency.dart';
import 'package:flutter_tips_app/data/models/employee.dart';
import 'package:flutter_tips_app/data/models/team.dart';

Currency dollar = Currency(name: 'доллары', rate: 91, amount: 0);
Currency euro = Currency(name: 'евро', rate: 96, amount: 0);
Currency pounds = Currency(name: 'фунты', rate: 116, amount: 0);

Team mockTeam = Team(
    name: 'FS',
    admin: 'Тимур',
    mainCurrencyName: 'рубли',
    mainCurrencySum: 54000,
    currencies: [dollar, euro, pounds]
    );

List<Employee> mockEmployees = [
  Employee(
    name: "Тимур",
    advance: 0,
    hours: 45,
    image: "https://example.com/image1.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
  Employee(
    name: "Арутик",
    advance: 0,
    hours: 0,
    image: "https://example.com/image2.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
  Employee(
    name: "Стас",
    advance: 0,
    hours: 0,
    image: "https://example.com/image3.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
  Employee(
    name: "Влад",
    advance: 0,
    hours: 0,
    image: "https://example.com/image4.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
  Employee(
    name: "Саша",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
  Employee(
    name: "Денис",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
  Employee(
    name: "Илья",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
  Employee(
    name: "Руслан",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
  Employee(
    name: "Максим",
    advance: 0,
    hours: 0,
    image: "https://example.com/image5.jpg",
    percent: 1.0,
    totalTips: 0,
  ),
];
