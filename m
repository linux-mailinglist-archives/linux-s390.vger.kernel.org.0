Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851C0167B5F
	for <lists+linux-s390@lfdr.de>; Fri, 21 Feb 2020 11:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBUKvq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 Feb 2020 05:51:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29626 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgBUKvp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 05:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582282304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhc7Aeo7e1JvMhEli3iiCo6/Skbd5NokA7m7mQnw5Kc=;
        b=FvKkcai4Cavi6IqgYuYemYoDZDkaRxhsbabyLOrfr/mY/GQl1UW9SLk8WjchmxZ2BcYO98
        YsE1JVgq5YpbzcicQY1hdcqmgmb+s22CQYHUU5Bu68Wj4DgzZZpt3s+ygg87ofUdNM6gi7
        E1BaedXxotrZ1MSjLhvqnhf9VXgU9So=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-Cz9WOtUxP0WiIxWMb98_Vw-1; Fri, 21 Feb 2020 05:51:40 -0500
X-MC-Unique: Cz9WOtUxP0WiIxWMb98_Vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA6B107ACC5;
        Fri, 21 Feb 2020 10:51:39 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53C4260C63;
        Fri, 21 Feb 2020 10:51:35 +0000 (UTC)
Date:   Fri, 21 Feb 2020 11:51:32 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Janosch Frank <frankja@linux.vnet.ibm.com>,
        KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 36/37] KVM: s390: rstify new ioctls in api.rst
Message-ID: <20200221115132.60b0fbde.cohuck@redhat.com>
In-Reply-To: <20200220104020.5343-37-borntraeger@de.ibm.com>
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
        <20200220104020.5343-37-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 20 Feb 2020 05:40:19 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> We also need to rstify the new ioctls that we added in parallel to the
> rstification of the kvm docs.

This looks like it could be merged independently of the protected virt
patches?

> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

