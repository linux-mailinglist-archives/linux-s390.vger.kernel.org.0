Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D18147A59
	for <lists+linux-s390@lfdr.de>; Fri, 24 Jan 2020 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgAXJYm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 24 Jan 2020 04:24:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729375AbgAXJYl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Jan 2020 04:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579857881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBy9mAgyZAkcbGIkW9GCY52hh6rAqPOSgsserAn7/vs=;
        b=X6CB8rrpu8TBXOlxcoz9K3ZUKY6q0Kfsbc4DinwPHboTX+ZwEFnu/pvMnJbiQCXe48WJXt
        /6o7Q9V1FlydTggrB/Jx7ym+6sy4D1EmSHL1TU1KWCLkW94/xXqwGXW4O7TFZjvqBUdB93
        IJ/AlWfxeNF53oHgTD8IG05SMEQrEM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166--vpZcwvjNj2Ttl-I3zCPhQ-1; Fri, 24 Jan 2020 04:24:37 -0500
X-MC-Unique: -vpZcwvjNj2Ttl-I3zCPhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C61021005513;
        Fri, 24 Jan 2020 09:24:35 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98E4987EDC;
        Fri, 24 Jan 2020 09:24:34 +0000 (UTC)
Date:   Fri, 24 Jan 2020 10:24:32 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] cio_ignore_proc_seq_next should increase position
 index
Message-ID: <20200124102432.0458ad45.cohuck@redhat.com>
In-Reply-To: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
References: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 24 Jan 2020 08:48:55 +0300
Vasily Averin <vvs@virtuozzo.com> wrote:

$SUBJECT: "s390/cio: ..." ?

> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
> 

Fixes: 678a395b356a ("[PATCH] s390: convert /proc/cio_ignore")

> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  drivers/s390/cio/blacklist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
> index 2a3f874..9cebff8 100644
> --- a/drivers/s390/cio/blacklist.c
> +++ b/drivers/s390/cio/blacklist.c
> @@ -303,8 +303,10 @@ struct ccwdev_iter {
>  cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
>  {
>  	struct ccwdev_iter *iter;
> +	loff_t p = *offset;

I was asking myself if we could avoid the new variable, but anything I
could think of looked worse.

>  
> -	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
> +	(*offset)++;
> +	if (p >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
>  		return NULL;
>  	iter = it;
>  	if (iter->devno == __MAX_SUBCHANNEL) {
> @@ -314,7 +316,6 @@ struct ccwdev_iter {
>  			return NULL;
>  	} else
>  		iter->devno++;
> -	(*offset)++;
>  	return iter;
>  }
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

