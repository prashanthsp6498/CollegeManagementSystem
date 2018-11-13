from flask import Flask, session, redirect, url_for, render_template, request
from database import connection

from wtforms import Form,TextField, IntegerField, TextAreaField, SubmitField, RadioField,SelectField,PasswordField

from wtforms import validators, ValidationError
from MySQLdb import escape_string as ths
app = Flask(__name__)
app.secret_key = "thisisscreteithink"

@app.route('/')
def page():
    return render_template('home.html')






#admin route start here;

@app.route('/admin',methods=['POST','GET'])
def admin():
    if request.method == 'POST':
        if request.form['username']=='prashanth' and request.form['password']=='PRASHANTH':
            session['user']=request.form['username']
            return redirect(url_for('adminHome'))
        else:
            error="username or password is incorrect"
        return render_template('login.html',error=error)
    return render_template('login.html')

@app.route('/admin/home')
def adminHome():
    if 'user' in session:
        return render_template('admin_home.html',username=session['user'])




class StudentRegistration(Form):
   name = TextField("Name",[validators.Required("Please enteryour name.")])
   gender = RadioField('Gender', choices = [('M','Male'),('F','Female')])
   usn = TextField("usn",[validators.Required("Please enteryour usn.")])
   sem = IntegerField("sem",[validators.Required("Please enteryour sem.")])
   phone = IntegerField("phone",[validators.Required("Please enteryour phone.")])
   email = TextField("Email",[validators.Required("Please enter your email address."),validators.Email("Please enter your email address.")])
   department = SelectField('Department', choices = [('cse', 'cse'),('ise', 'ise'),('ise', 'ise'),('mech', 'mech'),('civil', 'civil')])
   password = PasswordField("password",[validators.Required()])
   submit = SubmitField("Submit")


@app.route('/admin/studentRegister',methods=['GET', 'POST'])
def studentRegister():
    if 'user' in session:
        form = StudentRegistration(request.form)
        if request.method=="POST" and form.validate():
            name = form.name.data
            email = form.email.data
            usn = form.usn.data
            phone = form.phone.data
            sem = form.phone.data
            gender = form.gender.data
            department = form.department.data
            password = form.password.data
            c,con = connection()
            #x=c.execute("SELECT * FROM student WHERE usn=%s"% con.literal(usn))
            c.execute("INSERT INTO student (usn,name,sem,phone,department,email,password,gender) VALUES(%s,%s,%s,%s,%s,%s,%s,%s)",(usn,name,sem,phone,department,email,password,gender))
            con.commit()
            return  redirect(url_for('adminHome'))
        else:
            return render_template('student_register.html',form=form)
    else:
        return redirect(url_for(admin))


@app.route('/admin/home/logout')
def adminLogout():
    session.pop('user',None)
    return redirect(url_for('admin'))



class TeacherRegistration(Form):
   teacher_name = TextField("Name",[validators.Required("Please enter your name.")])
   gender = RadioField('Gender', choices = [('M','Male'),('F','Female')])
   empid = TextField("empid",[validators.Required("Please enteryour empid.")])
   phone = IntegerField("phone",[validators.Required("Please enteryour phone.")])
   email = TextField("Email",[validators.Required("Please enter your email address."),validators.Email("Please enter your email address.")])
   department = SelectField('Department', choices = [('cse', 'cse'),('ise', 'ise'),('ece', 'ece'),('mech', 'mech'),('civil', 'civil')])
   password = PasswordField("password",[validators.Required()])
   submit = SubmitField("Submit")



@app.route('/admin/teacherRegister',methods=['GET', 'POST'])
def teacherRegister():
    if 'user' in session:
        form = TeacherRegistration(request.form)
        if request.method=="POST" and form.validate():
            teacher_name = form.teacher_name.data
            email = form.email.data
            empid = form.empid.data
            phone = form.phone.data
            gender = form.gender.data
            department = form.department.data
            password = form.password.data
            c,con = connection()
            c.execute("INSERT INTO teacher (empid,name,phone,department,email,password,gender) VALUES(%s,%s,%s,%s,%s,%s,%s)",(empid,teacher_name,phone,department,email,password,gender))
            con.commit()
            return  redirect(url_for('adminHome'))
        else:
            return render_template('teacher_registration.html',form=form)
    else:
        return redirect(url_for(admin))


#student route start here;

@app.route('/student',methods=['GET', 'POST'])
def login():
    if request.method =='POST':
        c, conn = connection()
        c.execute("SELECT * FROM student WHERE usn=%s",[request.form['usn']])
        data = c.fetchone()[6]
        if data == request.form['password']:
            c.execute("SELECT * FROM student WHERE usn=%s",[request.form['usn']])
            d = c.fetchone()[0]
            session['user']= d
            return redirect(url_for('student_profile'))
        else:
            error = "usn or password is incorrect"
            return render_template('student_login.html',error=error)
    return render_template('student_login.html')

@app.route('/student/student_profile')
def student_profile():
    if 'user' in session:
        usn=session['user']
        c, conn = connection()
        c.execute("SELECT * FROM student WHERE usn=%s",[usn])
        student_info = c.fetchone()
        return render_template('profile.html',student_info=student_info)
    else:
        return redirect(url_for('login'))

@app.route('/student/viewmarks')
def student_marks():
    if 'user' in session:
        usn = session['user']
        c,conn = connection()
        c.execute("SELECT * FROM marks WHERE usn=%s",[usn])
        data = c.fetchall()
        return render_template('marks.html',data=data)

@app.route('/student/viewmarks/viewattendance')
def viewattendance():
    if 'user' in session:
        usn = session['user']
        c,conn = connection()
        c.execute("SELECT * FROM attendance WHERE usn=%s",[usn])
        data = c.fetchall()
        return render_template('attendance.html',data=data)


@app.route('/student/student_profile/logout')
def studentLogout():
    session.pop('user',None)
    return redirect(url_for('login'))

#teachers route start here;


@app.route('/teacher',methods=['GET', 'POST'])
def teacher_login():
    if request.method =='POST':
        c, conn = connection()
        c.execute("SELECT * FROM teacher WHERE empid=%s",[request.form['empid']])
        data = c.fetchone()[5]
        if data == request.form['password']:
            c.execute("SELECT * FROM teacher WHERE empid=%s",[request.form['empid']])
            d = c.fetchone()[0]
            session['user']= d
            return redirect(url_for('teacher_profile'))
        else:
            error = "usn or password is incorrect"
            return render_template('teacher_login.html',error=error)
    return render_template('teacher_login.html')

@app.route('/teacher/teacher_profile')
def teacher_profile():
    if 'user' in session:
        empid=session['user']
        c, conn = connection()
        c.execute("SELECT * FROM teacher WHERE empid=%s",[empid])
        teacher_info = c.fetchone()
        return render_template('teacher_profile.html',teacher_info=teacher_info)
    else:
        return redirect(url_for('login'))


class UpdateMarks(Form):
   usn = TextField("usn",[validators.Required("Please enter usn.")])
   subject_name = RadioField('subjects', choices = [('finite automata','finite automata'),
                                                    ('computer networks','computer networks'),
                                                    ('oo modeling and design','oo modeling and design'),
                                                    ('dbms','dbms'),
                                                    ('management','management'),
                                                    ('DotNet','DotNet'),
                                                    ('computer networks lab','computer networks lab'),
                                                    ('dbms lab','dbms lab')])
   internal1 = IntegerField("internal1",[validators.Required(".")])
   internal2 = IntegerField("internal2",[validators.Required("")])
   internal3 = IntegerField("internal3",[validators.Required("")])
   submit = SubmitField("Submit")

@app.route('/teacher/update_marks',methods=['GET', 'POST'])
def updatemarks():
    form = UpdateMarks(request.form)
    if request.method=="POST" and form.validate():
        usn = form.usn.data
        subject_name = form.subject_name.data
        internal1 = form.internal1.data
        internal2 = form.internal2.data
        internal3 = form.internal3.data
        c,con = connection()
        c.execute("INSERT INTO marks (usn,subject_name,internal1,internal2,internal3) VALUES(%s,%s,%s,%s,%s)",(usn,subject_name,internal1,internal2,internal3))
        con.commit()
        return  redirect(url_for('teacher_profile'))
    else:
        return render_template('update_marks.html',form=form)

class UpdateAttendance(Form):
   usn = TextField("usn",[validators.Required("Please enter usn.")])
   subject_name = RadioField('subjects', choices = [('finite automata','finite automata'),
                                                    ('computer networks','computer networks'),
                                                    ('oo modeling and design','oo modeling and design'),
                                                    ('dbms','dbms'),
                                                    ('management','management'),
                                                    ('DotNet','DotNet'),
                                                    ('computer networks lab','computer networks lab'),
                                                    ('dbms lab','dbms lab')])
   total_present = IntegerField("total present",[validators.Required(".")])
   total_class = IntegerField("total class",[validators.Required("")])
   submit = SubmitField("Submit")

@app.route('/teacher/update_attendance',methods=['GET', 'POST'])
def updateattendance():
    form = UpdateAttendance(request.form)
    if request.method=="POST" and form.validate():
        usn = form.usn.data
        subject_name = form.subject_name.data
        total_present = form.total_present.data
        total_class = form.total_class.data
        c,con = connection()
        c.execute("UPDATE attendance set total_present=%s,total_class=%s WHERE usn=%s AND subject_name=%s",(total_present,total_class,usn,subject_name))
        con.commit()
        return  redirect(url_for('teacher_profile'))
    else:
        return render_template('update_attendance.html',form=form)



@app.route('/teacher/home/logout')
def teacherLogout():
    session.pop('user',None)
    return redirect(url_for('teacher_login'))
