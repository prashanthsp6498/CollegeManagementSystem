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
        c,conn = connection()
        c.execute("SELECT COUNT(id) FROM student")
        student_data = c.fetchone()
        c.execute("SELECT COUNT(id) FROM teacher")
        teacher_data = c.fetchone()
        return render_template('admin_home.html',username=session['user'],student_data=student_data,teacher_data=teacher_data)

@app.route('/admin/studentRegister',methods=['GET', 'POST'])
def studentRegister():
    if 'user' in session:
        if request.method=="POST":
            name=request.form['name']
            email=request.form['email']
            usn=request.form['usn']
            phone=request.form['phone']
            sem=request.form['sem']
            gender=request.form['gender']
            department=request.form['department']
            password=request.form['password']
            c,con = connection()
            #x=c.execute("SELECT * FROM student WHERE usn=%s"% con.literal(usn))
            c.execute("INSERT INTO student (usn,name,sem,phone,department,email,password,gender) VALUES(%s,%s,%s,%s,%s,%s,%s,%s)",[usn,name,sem,phone,department,email,password,gender])
            con.commit()
            c.execute("INSERT INTO attendance(usn) values(%s)",[usn])
            con.commit()
            return  redirect(url_for('adminHome'))
        else:
            return render_template('student_register.html')
    else:
        return redirect(url_for(admin))


@app.route('/admin/home/logout')
def adminLogout():
    session.pop('user',None)
    return redirect(url_for('page'))


@app.route('/admin/teacherRegister',methods=['GET', 'POST'])
def teacherRegister():
    if 'user' in session:
        if request.method=="POST":
            teacher_name = request.form['name']
            email = request.form['email']
            empid = request.form['empid']
            phone = request.form['phone']
            gender = request.form['gender']
            department = request.form['department']
            salary = request.form['salary']
            password = request.form['password']
            c,con = connection()
            c.execute("INSERT INTO teacher (empid,name,phone,department,email,password,gender,salary) VALUES(%s,%s,%s,%s,%s,%s,%s,%s)",(empid,teacher_name,phone,department,email,password,gender,salary))
            con.commit()
            return  redirect(url_for('adminHome'))
        else:
            return render_template('teacher_registration.html')
    else:
        return redirect(url_for(admin))


@app.route('/admin/studentInfo',methods=['GET', 'POST'])
def studentInfo():
    if 'user' in session:
        if request.method=="POST":
            usn=request.form['usn']
            c,con = connection()
            c.execute("SELECT * FROM student WHERE usn=%s",[usn])
            data = c.fetchone()
            if data:
                return render_template('student_info.html',data=data)
            else:
                error="no record found"
                return render_template('student_info.html',error=error)
        else:
            return render_template('student_info.html')
    else:
        return redirect(url_for(admin))

@app.route('/admin/teacherInfo',methods=['GET', 'POST'])
def teacherInfo():
    if 'user' in session:
        if request.method=="POST":
            empid = request.form['empid']
            c,con = connection()
            c.execute("SELECT * FROM teacher WHERE empid=%s",[empid])
            data = c.fetchone()
            if data:
                return render_template('teacher_info.html',data=data)
            else:
                error="no record found"
                return render_template('teacher_info.html',error=error)
        else:
            return render_template('teacher_info.html')
    else:
        return redirect(url_for(admin))


#student route start here;

@app.route('/student',methods=['GET', 'POST'])
def login():
    if request.method =='POST':
        c, conn = connection()
        c.execute("SELECT * FROM student WHERE usn=%s",[request.form['usn']])
        data = c.fetchone()[7]
        if data == request.form['password']:
            c.execute("SELECT * FROM student WHERE usn=%s",[request.form['usn']])
            d = c.fetchone()[1]
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
    return redirect(url_for('page'))

#teachers route start here;


@app.route('/teacher',methods=['GET', 'POST'])
def teacher_login():
    if request.method =='POST':
        c, conn = connection()
        c.execute("SELECT * FROM teacher WHERE empid=%s",[request.form['empid']])
        data = c.fetchone()[6]
        if data == request.form['password']:
            c.execute("SELECT * FROM teacher WHERE empid=%s",[request.form['empid']])
            d = c.fetchone()[1]
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

@app.route('/teacher/update_marks',methods=['GET', 'POST'])
def updatemarks():
    if 'user' in session:
        if request.method=="POST":
            usn = request.form['usn']
            subject_name = request.form['subject_name']
            sem = request.form['sem']
            internal1 = request.form['internal1']
            internal2 = request.form['internal2']
            internal3 = request.form['internal3']
            c,con = connection()
            c.execute("INSERT INTO marks (usn,subject_name,internal1,internal2,internal3,sem) VALUES(%s,%s,%s,%s,%s,%s)",[usn,subject_name,internal1,internal2,internal3,sem])
            con.commit()
            return  redirect(url_for('teacher_profile'))
        else:
            return render_template('update_marks.html')

    else:
        return redirect(url_for('teacher_login'))

@app.route('/teacher/update_attendance',methods=['GET', 'POST'])
def updateattendance():
    if 'user' in session:
        if request.method=="POST":
            usn = request.form['usn']
            subject_name = request.form['subject_name']
            total_present = request.form['total_present']
            total_class = request.form['total_class']
            c,con = connection()
            c.execute("UPDATE attendance SET total_present=%s,total_class=%s,subject_name=%s WHERE usn=%s ",(total_present,total_class,subject_name,usn))
            con.commit()
            return  redirect(url_for('teacher_profile'))
        else:
            return render_template('update_attendance.html')

    else:
        return redirect(url_for('teacher_login'))


@app.route('/teacher/student_Info',methods=['GET', 'POST'])
def StudentInfo():
    if 'user' in session:
        if request.method=="POST":
            usn=request.form['usn']
            c,con = connection()
            c.execute("SELECT * FROM student WHERE usn=%s",[usn])
            data = c.fetchone()
            c.execute("SELECT * FROM marks where usn=%s",[usn])
            marks = c.fetchall()
            c.execute("SELECT * FROM attendance WHERE usn=%s",[usn])
            attendance = c.fetchall()
            if data:
                return render_template('teacher_studentinfo.html',data=data,marks=marks,attendance=attendance)
            else:
                error="no record found"
                return render_template('teacher_studentinfo.html',error=error)
        else:
            return render_template('teacher_studentinfo.html')
    else:
        return redirect(url_for(admin))

@app.route('/teacher/home/logout')
def teacherLogout():
    session.pop('user',None)
    return redirect(url_for('page'))
