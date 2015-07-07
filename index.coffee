# ===================================================================
# ======================= configure app =============================
# ===================================================================
path         = require 'path'
fs           = require 'fs'
express      = require 'express'
bodyParser   = require 'body-parser'
http         = require 'http'
serveStatic  = require 'serve-static' # use this because of mime type issues with express.static

# create web server instance
app     = express()

# TODO: do we need this?
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: false })

server 	= http.Server app
port = 3000
server.listen port, ->
	console.log "web server is listening on port #{port}"

# Set the public folder as static assets
app.use serveStatic path.join(__dirname, 'public')

menu_file_name = 'alacarte.json'

# get menu
app.get "/api/menu", (req, res) ->
	console.log "requested #{req.url}"
	res.sendFile path.join(__dirname, menu_file_name)

# send new menu
app.post "/api/menu", (req, res) ->
	console.log "posted #{req.url}"

	# saveto = "#{menu_file_name}_#{(new Date()).toISOString()}"
	# if !fs.exists menu_file_name
	# 	console.log "===================="
	# fs.renameSync menu_file_name, saveto
	# console.log "saved data to #{saveto}"

	json = JSON.stringify(req.body, null, 2)
	fs.writeFile menu_file_name, json, (err) ->
		if err
			console.log "error writing menu: #{err}"
			res.sendStatus(500)
		else
			res.sendStatus(200)

# basic routes
clientRoute = (req, res) ->
	console.log "requested #{req.url}"
	res.sendFile path.join(__dirname, 'public', 'index.html')

app.get "/", (req, res) ->
	clientRoute req, res

app.get "/view", (req, res) ->
	clientRoute req, res

app.get "/edit", (req, res) ->
	clientRoute req, res