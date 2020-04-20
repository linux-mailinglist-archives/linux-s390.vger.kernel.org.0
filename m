Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588491B014B
	for <lists+linux-s390@lfdr.de>; Mon, 20 Apr 2020 08:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgDTGFd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Apr 2020 02:05:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40292 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTGFc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 02:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587362731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jj2BQLu1NtQ9kzbeMgwxqS5hQo3Bx6Yhxp+ajWBSfOQ=;
        b=NdJ0gkvHHwduDL5K49xFeP50R2jY/ZWJPDgbYfvApH7oyzyhcqaOvwRM8Bw5YPcgn/T/zh
        kfXHiH5zQIfYNYTrOzSuMjStGAW5GPpx9JpGOF4Dh6ENn5zMVElC+z32/Ttgmzi6BdMiUW
        IFf+lKnTvwTEGktYQXk1dQnzpodv0Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-7u75-hjRMvCCSm_2jWJIuQ-1; Mon, 20 Apr 2020 02:05:27 -0400
X-MC-Unique: 7u75-hjRMvCCSm_2jWJIuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24DC18010FB;
        Mon, 20 Apr 2020 06:05:26 +0000 (UTC)
Received: from gondolin (ovpn-112-224.ams2.redhat.com [10.36.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FFAB60C80;
        Mon, 20 Apr 2020 06:05:21 +0000 (UTC)
Date:   Mon, 20 Apr 2020 08:05:18 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>, frankja@linux.ibm.com,
        pbonzini@redhat.com, david@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 1/1] MAINTAINERS: add a reviewer for KVM/s390
Message-ID: <20200420080518.7e190ab4.cohuck@redhat.com>
In-Reply-To: <5e0efa79-940e-6a43-fc71-532210e2d2e3@de.ibm.com>
References: <20200417152936.772256-1-imbrenda@linux.ibm.com>
        <5e0efa79-940e-6a43-fc71-532210e2d2e3@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 17 Apr 2020 17:39:44 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 17.04.20 17:29, Claudio Imbrenda wrote:
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6851ef7cf1bd..48e0147f9dd8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9326,6 +9326,7 @@ M:	Christian Borntraeger <borntraeger@de.ibm.com>
> >  M:	Janosch Frank <frankja@linux.ibm.com>
> >  R:	David Hildenbrand <david@redhat.com>
> >  R:	Cornelia Huck <cohuck@redhat.com>
> > +R:	Claudio Imbrenda <imbrenda@linux.ibm.com>
> >  L:	kvm@vger.kernel.org
> >  S:	Supported
> >  W:	http://www.ibm.com/developerworks/linux/linux390/
> >   
> 
> You cant have enough of the "R:"s 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 

Agreed :)

Acked-by: Cornelia Huck <cohuck@redhat.com>

