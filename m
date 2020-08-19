Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D4249A20
	for <lists+linux-s390@lfdr.de>; Wed, 19 Aug 2020 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHSKUh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 19 Aug 2020 06:20:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgHSKUe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 06:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597832433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqp0RLzyiqP2qlHXa0F96YjomzHg0Znfw14m2ZHyBNo=;
        b=Q0HwrXnTCueq/0KB6hpVKSx0u0vNCK5QzaPv1S+CKqa9Sq0V/KcL3LAKaKLI9NOILQEbUV
        /QWyzmE8dguPmOa87s0W8ugWey05ASMamgqTLPOM1qUmXsBulL6UGoTf1bEQ80e6+TYoed
        DTHpSTdn+AARwDPL2PHC11VoklQsi/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-18LsJdPcPD-jHatudp4NLw-1; Wed, 19 Aug 2020 06:20:30 -0400
X-MC-Unique: 18LsJdPcPD-jHatudp4NLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C70371084C8C;
        Wed, 19 Aug 2020 10:20:28 +0000 (UTC)
Received: from gondolin (ovpn-112-216.ams2.redhat.com [10.36.112.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4457A422;
        Wed, 19 Aug 2020 10:20:23 +0000 (UTC)
Date:   Wed, 19 Aug 2020 12:20:21 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Marc Hartmayer <mhartmay@linux.ibm.com>
Cc:     <kvm@vger.kernel.org>, Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH 1/4] common.bash: run `cmd` only if a
 test case was found
Message-ID: <20200819122021.43dd6ba6.cohuck@redhat.com>
In-Reply-To: <20200818130424.20522-2-mhartmay@linux.ibm.com>
References: <20200818130424.20522-1-mhartmay@linux.ibm.com>
        <20200818130424.20522-2-mhartmay@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 18 Aug 2020 15:04:21 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> It's only useful to run `cmd` in `for_each_unittest` if a test case
> was found. This change allows us to remove the guards from the
> functions `run_task` and `mkstandalone`.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  run_tests.sh            | 3 ---
>  scripts/common.bash     | 8 ++++++--
>  scripts/mkstandalone.sh | 4 ----
>  3 files changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

