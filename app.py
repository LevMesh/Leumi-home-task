# from flask import Flask, render_template

# app = Flask(__name__)

# # @app.route("/home")
# # def home():
# #     return "You are home baby"

# # @app.route("/shumel/overlord/nagibator")
# # def anime():
# #     return "<h1> Shumel Is the biggest OVERLORD fanboy <h1>"

# # @app.route("/lev")
# # def lev():
# #     return "hhhhhh You thought lev is here??? <h1> WRONG! <h1>"

# # @app.route("/Lev")
# # def Lev():
# #     return "<h1> OMG!! HOW did you found me?? <h1>"

# @app.route("/")
# def index():
#     return render_template('index.html')

# if __name__ == "__main__":

#     app.run(port=5000, host='0.0.0.0')




from flask import Flask, render_template
app = Flask(__name__)

@app.route('/')
def home():
   return render_template('index.html')
if __name__ == '__main__':
   app.run(port=5000, host='0.0.0.0')