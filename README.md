# Практическая работа №10 по Программированию корпоративных систем

## Мрясова Анастасия Александровна ЭФБО-01-22

Суть практической работы заключалась в привязке БД к приложению.
Были осуществлены функции взаимодействия с корзиной, связь с БД.

## БД
В качестве СУБД использовалась PostgreSQL, для взаимодействия с ней использовались пакеты pq и sqlx

ERD:

![image](https://github.com/user-attachments/assets/d0e5cfe4-e82a-496e-a0e9-c61965ff9de7)


## Серверная часть
Серверная часть располагается в папке *backend* и имеет следующую структуру:

![image](https://github.com/user-attachments/assets/d7d934d3-21d2-4295-b910-bfd9442a57c4)

### Детали
Директория cmd содержит пакет *main* – основной пакет программы, в нем находится функция main – точка входа в программу. Переменные окружения (пока это только порт и время ожидания ответа) указаны в файле *.env*.

Директория *internal* содержит все остальные пакеты, необходимые для работы приложения. Также в проекте используется пакет log/slog, который является стандартным пакетом для Go.
Разрабатываемая серверная часть так же была поделена на три уровня:  
1. **Handler** – пакет handler для обработки HTTP запросов и передачи данных на следующий уровень. 
2. **Service** – пакет service для бизнес логики и преобразования данных перед 
обращением к базе данных, если это необходимо. 
3. **Repository** – пакет repository для работы с хранилищем и выполнения всех запросов, относящихся к ней.
Уровни связаны друг с другом от самого верхнего к самому нижнему: handler связан с service, service связан с repository, repository непосредственно связана с хранилищем приложения, в данной практической - мапой данных.

Для поднятия сервера и написания хэндлеров был использован веб-фреймворк Gin, поэтому помимо логера log/slog запросы логируются с помощью логера Gin:

![image](https://github.com/user-attachments/assets/10dbc1e8-caff-465b-8255-15d640d9e53c)


### API 

Для работы приложения на данном этапе были реализованы функции добавления нового напитка, обновления напитка, получение всех напитков или одно напитка по его ID, удаление напитка, а также изменение статуса напитка - находится он в Избранном, либо нет.

![image](https://github.com/user-attachments/assets/8997d4ba-a363-4c2a-a52d-246270029555)

### Модель

Модели напитка, элемента корзины и объема описаны в файле entities.go в пакете *entitites*

```
package entities

type Drink struct {
	ID          int64    `json:"drink_id" db:"drink_id"`
	Name        string   `json:"name" db:"name"`
	ImageURL    string   `json:"image" db:"image"`
	Description string   `json:"description,omitempty" db:"description"`
	Compound    string   `json:"compound,omitempty" db:"compound"`
	Cold        bool     `json:"is_cold,omitempty" db:"is_cold"`
	Hot         bool     `json:"is_hot,omitempty" db:"is_hot"`
	Volumes     []Volume `json:"volumes,omitempty"`
	IsFavorite  bool     `json:"is_favorite"`
}

type Volume struct {
	ID     int64  `json:"volume_id" db:"volume_id"`
	Volume string `json:"volume" db:"volume"`
	Price  int64  `json:"price" db:"price"`
}

type CartItem struct {
	ID       int64  `json:"cart_item_id" db:"cart_item_id"`
	UserID   int64  `json:"user_id" db:"user_id"`
	Drink    Drink  `json:"drink"`
	Volume   Volume `json:"volume"`
	IsCold   bool   `json:"is_cold" db:"is_cold"`
	IsHot    bool   `json:"is_hot" db:"is_hot"`
	Quantity int64  `json:"quantity"`
}

```

## Клиентская часть

Серверная часть располагается в папке *frontend*, для связи с бэкендом был использован пакет Dio:

```
dependencies:
  dio: ^5.7.0
```

Управление профилем все еще осуществляются только на клиентской стороне, однако все взаимодействия с напитками (обновление, удаление, создание) и корзиной осуществляются посредством связи с серверной частью
Связь с бэкендом описана в файле api_service.dart, все модели находятся в папке models
Форма для создания и изменения напитка вынесена в компонент drink_form.dart в папке components

