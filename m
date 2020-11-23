Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E832C0FDA
	for <lists+linux-s390@lfdr.de>; Mon, 23 Nov 2020 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbgKWQKo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 23 Nov 2020 11:10:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732675AbgKWQKn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Nov 2020 11:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606147843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2miHvJgcl0BAZKSjTBkDnJuI4+C7dIt1zUfmtBpn/k=;
        b=VrMnUr9gjcAjaZp9R68mMMuqFyIIKtPGzufm5AvuEroeiKmAB7QT4zN4UgDYx3Z7yL1WIt
        BsIHChzXK3+E8AUOl6dJd4heyx59HetRuqcgNNdqceuk6xavxa/jivMxa5bG/UWxg6MSUe
        YaKasswpawAfwI6Rf8OBvuN5bnZso4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-wArw2x-MPqqLHnPHBz9anA-1; Mon, 23 Nov 2020 11:10:38 -0500
X-MC-Unique: wArw2x-MPqqLHnPHBz9anA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 623421007383;
        Mon, 23 Nov 2020 16:10:37 +0000 (UTC)
Received: from gondolin (ovpn-113-104.ams2.redhat.com [10.36.113.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0B9660873;
        Mon, 23 Nov 2020 16:10:32 +0000 (UTC)
Date:   Mon, 23 Nov 2020 17:10:30 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Janosch Frank <frankja@linux.vnet.ibm.com>,
        KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/gmap: make gmap memcg aware
Message-ID: <20201123171030.7f11dbc4.cohuck@redhat.com>
In-Reply-To: <20201117151023.424575-3-borntraeger@de.ibm.com>
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
        <20201117151023.424575-3-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 17 Nov 2020 16:10:23 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> gmap allocations can be attributed to a process.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 

Acked-by: Cornelia Huck <cohuck@redhat.com>

