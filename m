Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D9158107
	for <lists+linux-s390@lfdr.de>; Mon, 10 Feb 2020 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBJRNr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 10 Feb 2020 12:13:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52720 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728006AbgBJRNq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 12:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581354825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dui8FKqnJsFDSt2ZtSX4NUWkTHV6h0B5vMA/bHSnRxg=;
        b=KZ3ZRT2tVHf61zkl9ElbUysG5FyTf9O++nCElZrq2LVqvaQ10t8/RE2xI6u7vy/we/fqqX
        xgN4lIICYB96JawfZoyzqvjue7Twzkt0qlPjTsyHD57H2y4Af9khwP6JQ0Pdb8HCTEu6Wh
        edS4f0mwbGXg7krwjC78dpjD3EU3o80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-5hnAoYazNv-LWUgFngxXag-1; Mon, 10 Feb 2020 12:13:26 -0500
X-MC-Unique: 5hnAoYazNv-LWUgFngxXag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A51C78017CC;
        Mon, 10 Feb 2020 17:13:24 +0000 (UTC)
Received: from gondolin (ovpn-117-244.ams2.redhat.com [10.36.117.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A57826FB2;
        Mon, 10 Feb 2020 17:13:23 +0000 (UTC)
Date:   Mon, 10 Feb 2020 18:13:20 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 1/1] cio_ignore_proc_seq_next should increase position
 index
Message-ID: <20200210181320.2fc99f66.cohuck@redhat.com>
In-Reply-To: <51ac7c33-ea7d-d780-c9de-4858af5e5f18@de.ibm.com>
References: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
        <51ac7c33-ea7d-d780-c9de-4858af5e5f18@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 7 Feb 2020 14:13:05 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 24.01.20 06:48, Vasily Averin wrote:
> > if seq_file .next fuction does not change position index,
> > read after some lseek can generate unexpected output.
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=206283
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> > ---
> >  drivers/s390/cio/blacklist.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
> > index 2a3f874..9cebff8 100644
> > --- a/drivers/s390/cio/blacklist.c
> > +++ b/drivers/s390/cio/blacklist.c
> > @@ -303,8 +303,10 @@ struct ccwdev_iter {
> >  cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
> >  {
> >  	struct ccwdev_iter *iter;
> > +	loff_t p = *offset;
> >  
> > -	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
> > +	(*offset)++;
> > +	if (p >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
> >  		return NULL;
> >  	iter = it;
> >  	if (iter->devno == __MAX_SUBCHANNEL) {
> > @@ -314,7 +316,6 @@ struct ccwdev_iter {
> >  			return NULL;
> >  	} else
> >  		iter->devno++;
> > -	(*offset)++;
> >  	return iter;
> >  }
> >  
> >   
> 
> I guess this fixes one aspect:
> "dd: /proc/cio_ignore: cannot skip to specified offset"
> is now gone. So I am tempted to apply this. 

This is definitely an improvement.

> 
> but this code is still fishy:

I'm surprised it took that long; it's been 14 years since I messed
up^W^Wwrote this and there's basically only been a memory leak fix from
you in the meantime... that said, ...

> 
> $ cat /proc/cio_ignore 
> 0.0.fe00-0.0.fefe
> 0.0.ff00-0.0.ffff
> $ dd if=/proc/cio_ignore status=none
> 0.0.fe00-0.0.fefe
> 0.0.ff00-0.0.ffff
> $ dd if=/proc/cio_ignore status=none bs=10
> 0.0.fe00-0.0.fefe
> 0.0.ff00-0.0.ff01-0.0.ff02-0.0.ff03-0.0.ff04-0.0.ff05-0.0.ff06-0.0.ff07-0.0.ff08-0.0.ffff
> $ dd if=/proc/cio_ignore status=none bs=10 skip=1
> .0.fefe
> 0.0.ff00-0.0.ff01-0.0.ff02-0.0.ff03-0.0.ff04-0.0.ff05-0.0.ff06-0.0.ff07-0.0.ff08-0.0.ffff

...what we are doing is translating something that is basically a
per-possible-device value into a range, as otherwise the output would
be quite unreadable for humans. I'm not sure what the semantics should
be if you read in small chunks etc., as the ranges are assembled
on-the-fly.

> Peter, any opinions on this?

I *think* I originally modeled /proc/cio_ignore on a long-gone dasd
procfs file (a very long time before converting it to a seq file); do
we have any other examples of files that do a similar
individual-values-to-ranges conversion?

