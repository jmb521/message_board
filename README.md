plan:

User -
has_one_profile
3 roles - User, moderator, admin

user table to create
username
password
password_verify

no guest will have access since this is a private message board.

User can delete their own account
moderator can suspend a user.
Admin can delete a User
Admin can add or remove a moderator.


Profile belongs to user
Profile will contain:
profile picture


Post -
has_many_users
has_many :comments, through => users

post table to create




Comments
belongs_to :user
belongs_to :post
