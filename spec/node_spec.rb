require 'node'

describe Node do
  ('a'..'h').each do |node|
    let(node.to_sym) { described_class.new }
  end

  before do
    b > c > d > e > b > f > h
    b > a
    c > d
    c > e
  end

  it 'reaches connected nodes' do
    expect(b.reach?(a)).to be true
    expect(b.reach?(c)).to be true
    expect(b.reach?(f)).to be true
    expect(c.reach?(d)).to be true
    expect(c.reach?(e)).to be true
    expect(d.reach?(e)).to be true
    expect(e.reach?(b)).to be true
    expect(f.reach?(h)).to be true
  end

  it 'reaches nodes connected to connected nodes' do
    expect(a.reach?(a)).to be true
    expect(a.reach?(b)).to be false
    expect(a.reach?(c)).to be false
    expect(a.reach?(d)).to be false
    expect(a.reach?(e)).to be false
    expect(a.reach?(f)).to be false
    expect(a.reach?(g)).to be false
    expect(a.reach?(h)).to be false

    expect(b.reach?(a)).to be true
    expect(b.reach?(b)).to be true
    expect(b.reach?(c)).to be true
    expect(b.reach?(d)).to be true
    expect(b.reach?(e)).to be true
    expect(b.reach?(f)).to be true
    expect(b.reach?(g)).to be false
    expect(b.reach?(h)).to be true

    expect(c.reach?(a)).to be true
    expect(c.reach?(b)).to be true
    expect(c.reach?(c)).to be true
    expect(c.reach?(d)).to be true
    expect(c.reach?(e)).to be true
    expect(c.reach?(f)).to be true
    expect(c.reach?(g)).to be false
    expect(c.reach?(h)).to be true

    expect(d.reach?(a)).to be true
    expect(d.reach?(b)).to be true
    expect(d.reach?(c)).to be true
    expect(d.reach?(d)).to be true
    expect(d.reach?(e)).to be true
    expect(d.reach?(f)).to be true
    expect(d.reach?(g)).to be false
    expect(d.reach?(h)).to be true

    expect(e.reach?(a)).to be true
    expect(e.reach?(b)).to be true
    expect(e.reach?(c)).to be true
    expect(e.reach?(d)).to be true
    expect(e.reach?(e)).to be true
    expect(e.reach?(f)).to be true
    expect(e.reach?(g)).to be false
    expect(e.reach?(h)).to be true

    expect(f.reach?(a)).to be false
    expect(f.reach?(b)).to be false
    expect(f.reach?(c)).to be false
    expect(f.reach?(d)).to be false
    expect(f.reach?(e)).to be false
    expect(f.reach?(f)).to be true
    expect(f.reach?(g)).to be false
    expect(f.reach?(h)).to be true

    expect(g.reach?(a)).to be false
    expect(g.reach?(b)).to be false
    expect(g.reach?(c)).to be false
    expect(g.reach?(d)).to be false
    expect(g.reach?(e)).to be false
    expect(g.reach?(f)).to be false
    expect(g.reach?(g)).to be true
    expect(g.reach?(h)).to be false

    expect(h.reach?(a)).to be false
    expect(h.reach?(b)).to be false
    expect(h.reach?(c)).to be false
    expect(h.reach?(d)).to be false
    expect(h.reach?(e)).to be false
    expect(h.reach?(f)).to be false
    expect(h.reach?(g)).to be false
    expect(h.reach?(h)).to be true
  end

  it 'counts hops between nodes' do
    expect(b.hop_count(b)).to eq 0
    expect(b.hop_count(c)).to eq 1
    expect(b.hop_count(d)).to eq 2
    expect(b.hop_count(e)).to eq 2
    expect(c.hop_count(f)).to eq 3
  end
end