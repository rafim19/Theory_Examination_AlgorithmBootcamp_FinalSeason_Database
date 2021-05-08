-- Rafi Muhammad (rafim19)

CREATE DATABASE TheoryExamination
USE TheoryExamination

CREATE TABLE Users (
	userId char(5),
	userFirstName varchar(255) NOT NULL,
	userlastName varchar(255),
	userSchoolName varchar(255),
	userAddress varchar(255),
	userEmail varchar(255) NOT NULL,
	userPhoneNumber varchar(255) NOT NULL,
	userLocation varchar(255),
	userDOB date NOT NULL,
	userGender varchar(255) NOT NULL

	CONSTRAINT PK_userId
		PRIMARY KEY(userID),
	CONSTRAINT usersCheckId
		CHECK(userID like 'US[0-9][0-9][0-9]'),
	CONSTRAINT usersCheckEmail
		CHECK(userEmail like '%@%'),
	CONSTRAINT usersCheckPhoneNumber
		CHECK(userPhoneNumber like '+62%'),
	CONSTRAINT usersCheckGender
		CHECK(userGender = 'Male' OR userGender = 'Female')
)

-- DROP TABLE Users

-- COBA INSERT --
INSERT INTO Users (userId, userFirstName, userEmail, userPhoneNumber, userDOB, userGender)
VALUES ('US001', 'Rafi', 'rafimuhammad@gmail.com', '+6285156618923', '2002/01/19', 'Male')

-- CHECK CONSTRAINTS --
-- CHECK userID
INSERT INTO Users (userId, userFirstName, userEmail, userPhoneNumber, userDOB, userGender)
VALUES ('UD001', 'Rafi', 'rafimuhammad@gmail.com', '+6285156618923', '2002/01/19', 'Male')
-- CHECK userName
INSERT INTO Users (userId, userFirstName, userEmail, userPhoneNumber, userDOB, userGender)
VALUES ('US002', NULL, 'rafimuhammad@gmail.com', '+6285156618923', '2002/01/19', 'Male')
-- CHECK userEmail (Masih error)
INSERT INTO Users (userId, userFirstName, userEmail, userPhoneNumber, userDOB, userGender)
VALUES ('US003', 'Rafi', '@', '+6285156618923', '2002/01/19', 'Male')
-- CHECK userPhone Number
INSERT INTO Users (userId, userFirstName, userEmail, userPhoneNumber, userDOB, userGender)
VALUES ('US004', 'Rafi', 'rafimuhammad@gmail.com', '085156618923', '2002/01/19', 'Male')
-- CHECK userDOB
INSERT INTO Users (userId, userFirstName, userEmail, userPhoneNumber, userDOB, userGender)
VALUES ('US005', 'Rafi', 'rafimuhammad@gmail.com', '+6285156618923', NULL, 'Male')
-- CHECK userGender
INSERT INTO Users (userId, userFirstName, userEmail, userPhoneNumber, userDOB, userGender)
VALUES ('US006', 'Rafi', 'rafimuhammad@gmail.com', '+6285156618923', '2002/01/19', 'Gay')

SELECT * FROM Users

CREATE TABLE Friends (
	friendId char(5),
	userId char(5) NOT NULL,

	CONSTRAINT PK_friendId
		PRIMARY KEY(friendId),
	CONSTRAINT checkFriendId
		CHECK(friendId like 'FR[0-9][0-9][0-9]'),
	CONSTRAINT FK_Friends_userId
		FOREIGN KEY(userId) REFERENCES Users(userId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)

-- DROP TABLE Friends

-- COBA INSERT --
INSERT INTO Friends
VALUES ('FR001', 'US001')

-- CHECK CONSTRAINT --
-- CHECK friendId
INSERT INTO Friends
VALUES ('FS001', 'US00')
-- CHECK userId
INSERT INTO Friends
VALUES ('FR001', 'US002')

INSERT INTO Friends
VALUES ('FR002', NULL)

SELECT * FROM Friends

CREATE TABLE Pages (
	pageId char(5),
	pageName varchar(255) NOT NULL,
	pageContent varchar(255) NOT NULL

	CONSTRAINT PK_pageId
		PRIMARY KEY(pageId),
	CONSTRAINT pagesCheckId
		CHECK(pageId like 'PG[0-9][0-9][0-9]'),
	CONSTRAINT pagesUniqueName
		UNIQUE(pageName),
	CONSTRAINT pagesUniqueContent
		UNIQUE(pageContent)
)

-- DROP TABLE Pages

-- TES INSERT --
INSERT INTO Pages
VALUES ('PG001', 'Dashboard', 'Profile Name')

-- CHECK CONSTRAINT --
-- CHECK pageId
INSERT INTO Pages
VALUES ('PS002', 'Followers', 'Friends Name')
-- CHECK pageName
INSERT INTO Pages
VALUES ('PG002', NULL, 'Friends Name')
-- CHECK pageContent
INSERT INTO Pages
VALUES ('PS002', 'Followers', NULL)

SELECT * FROM Pages

CREATE TABLE Page_Likes (
	pageId char(5),
	userId char(5) NOT NULL

	CONSTRAINT PK_Page_Likes_pageId
		PRIMARY KEY(pageId),
	CONSTRAINT FK_Page_Likes_pageId
		FOREIGN KEY(pageId) REFERENCES Pages(pageId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT FK_Page_Likes_userId
		FOREIGN KEY(userId) REFERENCES Users(userId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)

-- DROP TABLE Page_Likes

-- TES INSERT --
INSERT INTO Page_Likes
VALUES ('PG001', 'US001')

-- CHECK CONSTRAINTS --
-- CHECK pageId
INSERT INTO Page_Likes
VALUES ('PG002', 'US001')
-- CHECK userId
INSERT INTO Page_Likes
VALUES ('PG001', 'US002')

SELECT * FROM Page_Likes

CREATE TABLE Posts (
	postId char(5),
	postContent varchar(255) NOT NULL,
	postDate date NOT NULL,
	userID char(5) NOT NULL

	CONSTRAINT PK_postId
		PRIMARY KEY(postId),
	CONSTRAINT checkPostsId
		CHECK(postId like 'PS[0-9][0-9][0-9]'),
	CONSTRAINT postsUniqueContent
		UNIQUE(postContent),
	CONSTRAINT FK_Posts_userId
		FOREIGN KEY(userId) REFERENCES Users(userId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)

-- DROP TABLE Posts

-- TES INSERT --
INSERT INTO Posts
VALUES ('PS001', 'Pentingnya ASI Bagi Para Bocil Kematian', '2021/05/08', 'US001')

-- CHECK CONSTRAINTS --
-- CHECK postId
INSERT INTO Posts
VALUES ('PG001', 'Tes aja', '2021/05/08', 'US001')
-- CHECK postContent (unique & not null)
INSERT INTO Posts
VALUES ('PS002', 'Pentingnya ASI Bagi Para Bocil Kematian', '2021/05/08', 'US001')

INSERT INTO Posts
VALUES ('PS002', NULL, '2021/05/08', 'US001')
-- CHECK postDate (not null)
INSERT INTO Posts
VALUES ('PS001', 'Tes aja', NULL, 'US001')
-- CHECK userId (not null)
INSERT INTO Posts
VALUES ('PS002', 'Tes aja', '2021/05/08', NULL)

SELECT * FROM Posts

CREATE TABLE Post_Likes (
	postLikesId char(5),
	postId char(5) NOT NULL,
	userId char(5) NOT NULL

	CONSTRAINT PK_postLikesId
		PRIMARY KEY(postLikesId),
	CONSTRAINT checkPostLikesId
		CHECK(postLikesId like 'PL[0-9][0-9][0-9]'),
	CONSTRAINT FK_Post_Likes_postId
		FOREIGN KEY(postId) REFERENCES Posts(postId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)

-- DROP TABLE Post_Likes

-- TES INSERT --
INSERT INTO Post_Likes
VALUES ('PL001', 'PS001', 'US001')

-- CHECK CONSTRAINT --
-- CHECK postLikesId
INSERT INTO Post_Likes
VALUES ('PA001', 'PS001', 'US001')
-- CHECK postId (not null)
INSERT INTO Post_Likes
VALUES ('PL001', NULL, 'US001')
-- CHECK userId
INSERT INTO Post_Likes
VALUES ('PL001', 'PS001', NULL)

SELECT * FROM Post_Likes

CREATE TABLE Photos (
	photoId char(5),
	imageContent image,
	postId char(5) NOT NULL,

	CONSTRAINT PK_photoId
		PRIMARY KEY(photoId),
	CONSTRAINT checkPhotosId
		CHECK(photoId like 'PH[0-9][0-9][0-9]'),
	CONSTRAINT FK_Photos_postId
		FOREIGN KEY(postId) REFERENCES Posts(postId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)

-- DROP TABLE Photos

-- TES INSERT --
INSERT INTO Photos (photoId, postId)
VALUES ('PH001', 'PS001')

-- CHECK CONSTRAINT --
-- CHECK photoId
INSERT INTO Photos (photoId, postId)
VALUES ('PJ001', 'PS001')
-- CHECK postId
INSERT INTO Photos (photoId, postId)
VALUES ('PH002', 'PS005')

SELECT * FROM Photos

CREATE TABLE Shares (
	shareId char(5),
	postId char(5) NOT NULL,
	userId char(5) NOT NULL

	CONSTRAINT PK_shareId
		PRIMARY KEY(shareId),
	CONSTRAINT checkSharesId
		CHECK(shareId like 'SH[0-9][0-9][0-9]'),
	CONSTRAINT FK_Shares_postId
		FOREIGN KEY(postId) REFERENCES Posts(postId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT FK_Shares_userId
		FOREIGN KEY(userId) REFERENCES Users(userId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)

-- DROP TABLE Shares

-- TES INSERT --
INSERT INTO Shares
VALUES ('SH001', 'PS001', 'US001')

-- CHECK CONSTRAINTS --
-- CHECK shareId
INSERT INTO Shares
VALUES ('SP001', 'PS001', 'US001')
-- CHECK postId
INSERT INTO Shares
VALUES ('SH002', 'PS005', 'US001')
-- CHECK userId
INSERT INTO Shares
VALUES ('SH002', 'PS001', 'US005')

SELECT * FROM Shares

CREATE TABLE Comments (
	commentId char(5),
	commentDate date NOT NULL,
	commentContent varchar(255) NOT NULL,
	userId char(5) NOT NULL

	CONSTRAINT PK_commentId
		PRIMARY KEY(commentId),
	CONSTRAINT checkCommentsId
		CHECK(commentId like 'CM[0-9][0-9][0-9]'),
	CONSTRAINT FK_Comments_userId
		FOREIGN KEY(userId) REFERENCES Users(userId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)

-- DROP TABLE Comments

-- TES INSERT --
INSERT INTO Comments
VALUES ('CM001', '2021/05/08', 'Bagus banget artikelnya!', 'US001')

-- CHECK CONSTRAINTS --
-- CHECK commentId
INSERT INTO Comments
VALUES ('CP001', '2021/05/08', 'Bagus banget artikelnya!', 'US001')
-- CHECK commentDate
INSERT INTO Comments
VALUES ('CM002', NULL, 'Bagus banget artikelnya!', 'US001')
-- CHECK commentContent
INSERT INTO Comments
VALUES ('CM002', '2021/05/08', NULL, 'US001')
-- CHECK userId
INSERT INTO Comments
VALUES ('CM002', '2021/05/08', 'Bagus banget artikelnya!', 'US005')

SELECT * FROM Comments

CREATE TABLE Comment_Likes (
	commentLikeId char(5),
	commentId char(5) NOT NULL,
	userId char(5) NOT NULL

	CONSTRAINT PK_commentLikeId
		PRIMARY KEY(commentLikeId),
	CONSTRAINT checkCommentLikesId
		CHECK(commentLikeId like 'CL[0-9][0-9][0-9]'),
	CONSTRAINT FK_Comment_Likes_commentId
		FOREIGN KEY(commentId) REFERENCES Comments(commentId)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT FK_Comment_Likes_userId
		FOREIGN KEY(userId) REFERENCES Users(userId)
		ON DELETE NO ACTION
)

-- DROP TABLE Comment_Likes

-- TES INSERT --
INSERT INTO Comment_Likes
VALUES ('CL001', 'CM001', 'US001')

-- CHECK CONSTRAINT --
-- CHECK commentLikeId
INSERT INTO Comment_Likes
VALUES ('CP001', 'CM001', 'US001')
-- CHECK commentId
INSERT INTO Comment_Likes
VALUES ('CL002', 'CM007', 'US001')
-- CHECK userId
INSERT INTO Comment_Likes
VALUES ('CL002', 'CM001', 'US100')

SELECT * FROM Comment_Likes