Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1600E1B709
	for <lists+linux-s390@lfdr.de>; Mon, 13 May 2019 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfEMN3f (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 13 May 2019 09:29:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfEMN3f (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 May 2019 09:29:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4203E308620E;
        Mon, 13 May 2019 13:29:34 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 239FF5C225;
        Mon, 13 May 2019 13:29:26 +0000 (UTC)
Date:   Mon, 13 May 2019 15:29:24 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
Message-ID: <20190513152924.1e8e8f5a.cohuck@redhat.com>
In-Reply-To: <20190512202256.5517592d.pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-6-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905081447280.1773@schleppi>
        <20190508232210.5a555caa.pasic@linux.ibm.com>
        <20190509121106.48aa04db.cohuck@redhat.com>
        <20190510001112.479b2fd7.pasic@linux.ibm.com>
        <20190510161013.7e697337.cohuck@redhat.com>
        <20190512202256.5517592d.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 13 May 2019 13:29:34 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, 12 May 2019 20:22:56 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 10 May 2019 16:10:13 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri, 10 May 2019 00:11:12 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > On Thu, 9 May 2019 12:11:06 +0200
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >   
> > > > On Wed, 8 May 2019 23:22:10 +0200
> > > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > > >     
> > > > > On Wed, 8 May 2019 15:18:10 +0200 (CEST)
> > > > > Sebastian Ott <sebott@linux.ibm.com> wrote:    
> > > >     
> > > > > > > @@ -1063,6 +1163,7 @@ static int __init css_bus_init(void)
> > > > > > >  		unregister_reboot_notifier(&css_reboot_notifier);
> > > > > > >  		goto out_unregister;
> > > > > > >  	}
> > > > > > > +	cio_dma_pool_init();        
> > > > > > 
> > > > > > This is too late for early devices (ccw console!).      
> > > > > 
> > > > > You have already raised concern about this last time (thanks). I think,
> > > > > I've addressed this issue: the cio_dma_pool is only used by the airq
> > > > > stuff. I don't think the ccw console needs it. Please have an other look
> > > > > at patch #6, and explain your concern in more detail if it persists.    
> > > > 
> > > > What about changing the naming/adding comments here, so that (1) folks
> > > > aren't confused by the same thing in the future and (2) folks don't try
> > > > to use that pool for something needed for the early ccw consoles?
> > > >     
> > > 
> > > I'm all for clarity! Suggestions for better names?  
> > 
> > css_aiv_dma_pool, maybe? Or is there other cross-device stuff that may
> > need it?
> >   
> 
> Ouch! I was considering to use cio_dma_zalloc() for the adapter
> interruption vectors but I ended up between the two chairs in the end.
> So with this series there are no uses for cio_dma pool.
> 
> I don't feel strongly about this going one way the other.
> 
> Against getting rid of the cio_dma_pool and sticking with the speaks
> dma_alloc_coherent() that we waste a DMA page per vector, which is a
> non obvious side effect.

That would basically mean one DMA page per virtio-ccw device, right?
For single queue devices, this seems like quite a bit of overhead.

Are we expecting many devices in use per guest?

> 
> What speaks against cio_dma_pool is that it is slightly more code, and
> this currently can not be used for very early stuff, which I don't
> think is relevant. 

Unless properly documented, it feels like something you can easily trip
over, however.

I assume that the "very early stuff" is basically only ccw consoles.
Not sure if we can use virtio-serial as an early ccw console -- IIRC
that was only about 3215/3270? While QEMU guests are able to use a 3270
console, this is experimental and I would not count that as a use case.
Anyway, 3215/3270 don't use adapter interrupts, and probably not
anything cross-device, either; so unless early virtio-serial is a
thing, this restriction is fine if properly documented.

> What also used to speak against it is that
> allocations asking for more than a page would just fail, but I addressed
> that in the patch I've hacked up on top of the series, and I'm going to
> paste below. While at it I addressed some other issues as well.

Hm, which "other issues"?

> 
> I've also got code that deals with AIRQ_IV_CACHELINE by turning the
> kmem_cache into a dma_pool.

Isn't that percolating to other airq users again? Or maybe I just don't
understand what you're proposing here...

> 
> Cornelia, Sebastian which approach do you prefer:
> 1) get rid of cio_dma_pool and AIRQ_IV_CACHELINE, and waste a page per
> vector, or
> 2) go with the approach taken by the patch below?

I'm not sure that I properly understand this (yeah, you probably
guessed); so I'm not sure I can make a good call here.

> 
> 
> Regards,
> Halil
> -----------------------8<---------------------------------------------
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Sun, 12 May 2019 18:08:05 +0200
> Subject: [PATCH] WIP: use cio dma pool for airqs
> 
> Let's not waste a DMA page per adapter interrupt bit vector.
> ---
> Lightly tested...
> ---
>  arch/s390/include/asm/airq.h |  1 -
>  drivers/s390/cio/airq.c      | 10 +++-------
>  drivers/s390/cio/css.c       | 18 +++++++++++++++---
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/include/asm/airq.h b/arch/s390/include/asm/airq.h
> index 1492d48..981a3eb 100644
> --- a/arch/s390/include/asm/airq.h
> +++ b/arch/s390/include/asm/airq.h
> @@ -30,7 +30,6 @@ void unregister_adapter_interrupt(struct airq_struct *airq);
>  /* Adapter interrupt bit vector */
>  struct airq_iv {
>  	unsigned long *vector;	/* Adapter interrupt bit vector */
> -	dma_addr_t vector_dma; /* Adapter interrupt bit vector dma */
>  	unsigned long *avail;	/* Allocation bit mask for the bit vector */
>  	unsigned long *bitlock;	/* Lock bit mask for the bit vector */
>  	unsigned long *ptr;	/* Pointer associated with each bit */
> diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
> index 7a5c0a0..f11f437 100644
> --- a/drivers/s390/cio/airq.c
> +++ b/drivers/s390/cio/airq.c
> @@ -136,8 +136,7 @@ struct airq_iv *airq_iv_create(unsigned long bits, unsigned long flags)
>  		goto out;
>  	iv->bits = bits;
>  	size = iv_size(bits);
> -	iv->vector = dma_alloc_coherent(cio_get_dma_css_dev(), size,
> -						 &iv->vector_dma, GFP_KERNEL);
> +	iv->vector = cio_dma_zalloc(size);
>  	if (!iv->vector)
>  		goto out_free;
>  	if (flags & AIRQ_IV_ALLOC) {
> @@ -172,8 +171,7 @@ struct airq_iv *airq_iv_create(unsigned long bits, unsigned long flags)
>  	kfree(iv->ptr);
>  	kfree(iv->bitlock);
>  	kfree(iv->avail);
> -	dma_free_coherent(cio_get_dma_css_dev(), size, iv->vector,
> -			  iv->vector_dma);
> +	cio_dma_free(iv->vector, size);
>  	kfree(iv);
>  out:
>  	return NULL;
> @@ -189,9 +187,7 @@ void airq_iv_release(struct airq_iv *iv)
>  	kfree(iv->data);
>  	kfree(iv->ptr);
>  	kfree(iv->bitlock);
> -	kfree(iv->vector);
> -	dma_free_coherent(cio_get_dma_css_dev(), iv_size(iv->bits),
> -			  iv->vector, iv->vector_dma);
> +	cio_dma_free(iv->vector, iv_size(iv->bits));
>  	kfree(iv->avail);
>  	kfree(iv);
>  }
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index 7087cc3..88d9c92 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -1063,7 +1063,10 @@ struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages)
>  static void __gp_dma_free_dma(struct gen_pool *pool,
>  			      struct gen_pool_chunk *chunk, void *data)
>  {
> -	dma_free_coherent((struct device *) data, PAGE_SIZE,
> +
> +	size_t chunk_size = chunk->end_addr - chunk->start_addr + 1;
> +
> +	dma_free_coherent((struct device *) data, chunk_size,
>  			 (void *) chunk->start_addr,
>  			 (dma_addr_t) chunk->phys_addr);
>  }
> @@ -1088,13 +1091,15 @@ void *cio_gp_dma_zalloc(struct gen_pool *gp_dma, struct device *dma_dev,
>  {
>  	dma_addr_t dma_addr;
>  	unsigned long addr = gen_pool_alloc(gp_dma, size);
> +	size_t chunk_size;
>  
>  	if (!addr) {
> +		chunk_size = round_up(size, PAGE_SIZE);

Doesn't that mean that we still go up to chunks of at least PAGE_SIZE?
Or can vectors now share the same chunk?

>  		addr = (unsigned long) dma_alloc_coherent(dma_dev,
> -					PAGE_SIZE, &dma_addr, CIO_DMA_GFP);
> +					 chunk_size, &dma_addr, CIO_DMA_GFP);
>  		if (!addr)
>  			return NULL;
> -		gen_pool_add_virt(gp_dma, addr, dma_addr, PAGE_SIZE, -1);
> +		gen_pool_add_virt(gp_dma, addr, dma_addr, chunk_size, -1);
>  		addr = gen_pool_alloc(gp_dma, size);
>  	}
>  	return (void *) addr;
> @@ -1108,6 +1113,13 @@ void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size)
>  	gen_pool_free(gp_dma, (unsigned long) cpu_addr, size);
>  }
>  
> +/**
> + * Allocate dma memory from the css global pool. Intended for memory not
> + * specific to any single device within the css.
> + *
> + * Caution: Not suitable for early stuff like console.

Maybe add "Do not use prior to <point in startup>"?

> + *
> + */
>  void *cio_dma_zalloc(size_t size)
>  {
>  	return cio_gp_dma_zalloc(cio_dma_pool, cio_get_dma_css_dev(), size);

