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
