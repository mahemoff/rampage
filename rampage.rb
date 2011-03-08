
$monsters = [
  {
    :id => :lizzie,
    :name => "Lizzie",
    :born => 1986,
    :food => "men"
  },
  {
    :id => :george,
    :name => "George",
    :born => 1986,
    :food => "men"
  },
  {
    :id => :ralph,
    :name => "Ralph",
    :born => 1986,
    :food => "businessmen"
  }
]

get '/' do
  mustache :home, :layout=>true
end

get '/monsters' do
  mustache :monsters, :monsters=>$monsters, :layout=>true
end

get '/monsters.json' do
  $monsters.to_json
end

get %r{/monsters/([^w]+).json} do |monster|
  content_type :json
  get_monster(monster).to_json
end

get '/monsters/:monster' do
  mustache :monster, :monster=>get_monster(params[:monster]), :layout=>true
end

def mustache(template, args={})
  content = Mustache.render File.new("#{:views}/#{template}.mustache", "r").read, args
  if args[:layout]
    Mustache.render File.new("#{:views}/layout.mustache", "r").read,
      :yield => content,
      :monsters_template=>File.new("#{:views}/monsters.mustache", "r").read,
      :monster_template=>File.new("#{:views}/monster.mustache", "r").read
  else
    content
  end
end

def get_monster(id)
  $monsters.select {|monster| monster[:id].to_s==id.to_s} [0]
end
