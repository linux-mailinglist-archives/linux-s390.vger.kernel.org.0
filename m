Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA36E16C041
	for <lists+linux-s390@lfdr.de>; Tue, 25 Feb 2020 13:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgBYMIG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 25 Feb 2020 07:08:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24722 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgBYMIF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 07:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582632484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwHUjFvRK56EZJPMucjcV1zfupoXECmfujv7nzMfOWI=;
        b=MrD5YpgwlnfKUO+qglNbSPN18P6Brq9/OHlDypKuW3RLyEzwmbfGTHI/fDDbBQ4l4jLxaQ
        7iNtl0zL5NwOXLRFkVbEmgYNGS+zg4zfzi5NyrGNFdUFyg2xz/g+EG5/CvFiUT+1AcG0Um
        +MNixFv3MdKy/AN8SQwv7pkBdslDLM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-vyAUbC6kPYeSFO-_wseP9g-1; Tue, 25 Feb 2020 07:08:03 -0500
X-MC-Unique: vyAUbC6kPYeSFO-_wseP9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B8B18C35A0;
        Tue, 25 Feb 2020 12:08:01 +0000 (UTC)
Received: from gondolin (dhcp-192-175.str.redhat.com [10.33.192.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 314EF90CF5;
        Tue, 25 Feb 2020 12:07:57 +0000 (UTC)
Date:   Tue, 25 Feb 2020 13:07:54 +0100
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
Subject: Re: [PATCH v4 14/36] KVM: s390: protvirt: Implement interrupt
 injection
Message-ID: <20200225130754.06d4c02a.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-15-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-15-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 24 Feb 2020 06:40:45 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.ibm.com>
> 
> This defines the necessary data structures in the SIE control block to
> inject machine checks,external and I/O interrupts. We first define the
> the interrupt injection control, which defines the next interrupt to
> inject. Then we define the fields that contain the payload for machine
> checks,external and I/O interrupts.
> This is then used to implement interruption injection for the following
> list of interruption types:
> 
>    - I/O (uses inject io interruption)
>      __deliver_io
> 
>    - External (uses inject external interruption)
>      __deliver_cpu_timer
>      __deliver_ckc
>      __deliver_emergency_signal
>      __deliver_external_call
> 
>    - cpu restart (uses inject restart interruption)
>      __deliver_restart
> 
>    - machine checks (uses mcic, failing address and external damage)
>      __write_machine_check
> 
> Please note that posted interrupts (GISA) are not used for protected
> guests as of today.
> 
> The service interrupt is handled in a followup patch.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  62 +++++++++++++----
>  arch/s390/kvm/interrupt.c        | 115 +++++++++++++++++++++++--------
>  2 files changed, 138 insertions(+), 39 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

