module PlacesHelper
    def recommends(place)
        ((place.recommend+place.comments.sum(:recommend))/(place.comments.count+1).to_f).round(2)
    end
end
