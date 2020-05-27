# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/spec'

describe ArrayUtils do
  it 'reises ArgumentError when used with invalid arguments' do
    expect { ArrayUtils.flatten_integers }.must_raise(ArgumentError)
    expect { ArrayUtils.flatten_integers(1) }.must_raise(ArgumentError)
    expect { ArrayUtils.flatten_integers('string') }.must_raise(ArgumentError)
    expect { ArrayUtils.flatten_integers(nil) }.must_raise(ArgumentError)
    expect { ArrayUtils.flatten_integers([1, nil]) }.must_raise(ArgumentError)
    expect { ArrayUtils.flatten_integers([1, 'string']) }.must_raise(ArgumentError)
    expect { ArrayUtils.flatten_integers([1, 1.1]) }.must_raise(ArgumentError)
    expect { ArrayUtils.flatten_integers([1, 2, ['string']]) }.must_raise(ArgumentError)
  end

  it 'works with integer arrays' do
    ArrayUtils.flatten_integers([]).must_equal([])
    ArrayUtils.flatten_integers([1]).must_equal([1])
    ArrayUtils.flatten_integers([1, 2]).must_equal([1, 2])
    ArrayUtils.flatten_integers([1, 2, [3]]).must_equal([1, 2, 3])
    ArrayUtils.flatten_integers([[1, 2, [3]], 4]).must_equal([1, 2, 3, 4])
  end
end
