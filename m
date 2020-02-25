Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE48D16BEF0
	for <lists+linux-s390@lfdr.de>; Tue, 25 Feb 2020 11:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgBYKiM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 25 Feb 2020 05:38:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729417AbgBYKiJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 05:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582627088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jqnld3IWzEPhjTNh7/Ue+5D/9dR2OPNa17JHf0tlptE=;
        b=BLYWWM2p7brG/2CsgPzRV1si7eaWEphVWo2XxXWYQNFuDs5VO8iU13CazmqquHOZDKPlJ/
        c9uBxm6ntkN4phYoOafH7xQWEyrIT/uGOOoXFVrn/fim4vd8snqSkgtyX2FmO+PZNNklkT
        5GR1UoOjRdCfwtg2cQA5W98f9G1xPsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-j9R5V388NRyyd7Eo30mLZQ-1; Tue, 25 Feb 2020 05:38:04 -0500
X-MC-Unique: j9R5V388NRyyd7Eo30mLZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5538E800D54;
        Tue, 25 Feb 2020 10:38:03 +0000 (UTC)
Received: from gondolin (dhcp-192-175.str.redhat.com [10.33.192.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07C6F19C58;
        Tue, 25 Feb 2020 10:37:58 +0000 (UTC)
Date:   Tue, 25 Feb 2020 11:37:56 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Janosch Frank <frankja@linux.vnet.ibm.com>,
        KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v4 06/36] s390/mm: add (non)secure page access
 exceptions handlers
Message-ID: <20200225113756.3f182952.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-7-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-7-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 24 Feb 2020 06:40:37 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Vasily Gorbik <gor@linux.ibm.com>
> 
> Add exceptions handlers performing transparent transition of non-secure
> pages to secure (import) upon guest access and secure pages to
> non-secure (export) upon hypervisor access.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> [frankja@linux.ibm.com: adding checks for failures]
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [imbrenda@linux.ibm.com:  adding a check for gmap fault]
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/pgm_check.S |  4 +-
>  arch/s390/mm/fault.c         | 78 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 2 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

