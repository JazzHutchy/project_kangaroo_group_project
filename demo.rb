people = [{
    name: 'sally',
    idea: {
        vote: 3
    }
},
{
    name: 'peter',
    idea: {
        vote: 42
    }
},
{
    name: 'john',
    idea: {
        vote: 18
    }
}]

vote = 0
winner = nil
people.each do |person|
    if vote < person[:idea][:vote] #true
        vote = person[:idea][:vote]
        winner = person
    end
end

puts winner[:name]