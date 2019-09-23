# README

# Place Sharing App dev setup

# Ruby version
```
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin17]
```

# Default login and password
```
email: admin@example.com
password: admin@123
```

#### 1. Add new user for PostgreSQL

```bash
sudo adduser spp_user
```
and give UNIX password as admin.

Create a corresponding user in postgres and set the password there:

```bash
su postgres

psql template1
```

`psql` command will take you to postgres console. Following commands to be run there:

```sql
CREATE USER spp_user WITH PASSWORD 'admin';

ALTER ROLE spp_user WITH CREATEDB Replication;
```
#### OR Add the existing postgresql username and password to project database.yml

#### 2. Database setup

```bash
rake db:drop && rake db:create && rake db:migrate && rake db:seed
```

#### 3. Start rails server

```bash
bin/rails s
```
and go to `localhost:3000`. You should see the login page.

#### 4. APIs
```bash
$ HOST http://localhost:3000 OR any other
```
1.to get the list of existing survey
```bash
$ GET /api/surveys
```
2.to add questions to the survey
```bash
$ POST /api/surveys/:id/questions
Body params
{
	"questions_attributes" : {
		"content" : "What is your age?"
	}
}
```
3.to get questions to the survey
```bash
$ GET /api/surveys/:id/questions
```
4.to delete questions to the survey
```bash
$ DELETE /api/surveys/:id/questions/:question_id
```
5.to take the survey
```bash
$ POST /api/surveys/take_survey
Body params
{
	"questions_attributes" : {
		"id" : 17,
		 "answers_attributes": {
		 	"content": "Absolutly yes Brother"
		 }
	}
}
```

Use user details like 'email and password'(which is admin) from seed file to login or You can sign up and use those credential to login and ask administrator to mark you 'Admin' manually.
