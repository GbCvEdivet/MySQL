DROP TABLE IF EXISTS music;
CREATE TABLE music(
	id SERIAL,
	singer VARCHAR(100),
	track VARCHAR(100),
	created_at DATETIME DEFAULT NOW(),
	metadata JSON,
	
	INDEX (track, singer)
);

DROP TABLE IF EXISTS users_music;
CREATE TABLE users_music (
	user_id BIGINT UNSIGNED NOT NULL,
	music_id BIGINT UNSIGNED NOT NULL,	
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (music_id) REFERENCES music(id)
);

DROP TABLE IF EXISTS newsline;
CREATE TABLE newsline (
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	body TEXT,
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);