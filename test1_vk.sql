select
	install_date, final_date, max(payment) payments_sum 
from 
	(select 
		install_date, 
        final_date, 
		(sum(intermed.value) over 
		(partition by intermed.install_date
		order by intermed.id)) payment
	from 
		(select 
		payments.payments_id id, 
                installs.date install_date, 
                payments.date final_date, 
                payments.value value
		from 
			installs join payments
		on
			installs.player_id = payments.player_id) intermed
where
	(intermed.install_date between '2019-09-01' and '2019-09-30')
    and (intermed.final_date between '2019-09-01' and '2019-09-30')) results
group by
	install_date, final_date;
