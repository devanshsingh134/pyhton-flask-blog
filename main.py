from flask import Flask, render_template, request, session, redirect, flash
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
from flask_mail import Mail
import os
from werkzeug.utils import secure_filename

import time

with open('config.json', 'r') as c:
    params = json.load(c)["params"]
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = params['upload_location']
app.config['UPLOAD_EXTENSIONS'] = ['.jpg', '.png', '.gif']
app.secret_key = "super-secret-key"
app.config['SQLALCHEMY_DATABASE_URI'] = params['uri']
db = SQLAlchemy(app)
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)
mail = Mail(app)


class Contacts(db.Model):
    '''
    sno, name phone_num, msg, date, email
    '''
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    ph_num = db.Column(db.String(12), nullable=True)
    mes = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)


class Posts(db.Model):
    '''
    sno, title, slug, content, date, sub, postby, img_file
    '''
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(12), nullable=True)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    sub = db.Column(db.String(20), nullable=False)
    img_file = db.Column(db.String(12), nullable=True)


@app.route("/about")
def about():
    return render_template('about.html', params=params)


@app.route("/post")
def post():
    post = Posts.query.filter_by().first()
    return render_template('post.html', params=params, post=post)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


# @app.route("/uploader" , methods=['GET', 'POST'])
# def uploader():
#     if "user" in session and session['user']==params['admin-username']:
#         if request.method=='POST':
#             posts=request.form.get('title')
#             f = request.files['img_file']
#             f.filename=posts
#             f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last=(len(posts)/2)
    page=request.args.get("page")
    if not str(page).isnumeric():
        page=1
    page=int(page)
    posts=posts[(page-1)*2:(page-1)*2+2]
    if page==1:
        prev="#"
        next="/?page="+str(page+1)
    elif page==last:
        prev="/?page="+str(page-1)
        next="#"
    else:
        next = "/?page=" + str(page + 1)
        prev = "/?page=" + str(page - 1)

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


@app.route("/dashboard", methods=['GET','POST'])
def dashboard():
    if 'user' in session and session['user'] == params['admin-username']:


        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == "POST":
        username = request.form.get("uname")
        userpass = request.form.get("upass")
        if username == params['admin-username'] and userpass == params['admin-pass']:
            flash("you are successfully logged in", 'error')
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)
    flash("Invalid Credentials", 'error')
    return render_template('login.html', params=params)

@app.route('/logout')
def logout():
    session.pop('user',None)
    return render_template('login.html', params=params)


@app.route("/edit/<string:sno>", methods = ['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin-username']):

        if request.method == 'POST':
            post=request.form.get('title')
            f = request.files['img_file']
            f.filename=post+'.jpg'
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))

        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = secure_filename(f.filename)
            date = datetime.now()

            if sno=='0':
                post = Posts(title=box_title, slug=slug, content=content, sub=tline, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.sub = tline
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post, sno=sno)





@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin-username']):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect('/dashboard')


@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        '''Add entry to the database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name, ph_num=phone, mes=message, date=datetime.now(), email=email)
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New message from ' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body=message + "\n" + phone
                          )
    return render_template('contact.html', params=params)


app.run(debug=True)
