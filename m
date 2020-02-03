Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6373C150515
	for <lists+linux-s390@lfdr.de>; Mon,  3 Feb 2020 12:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBCLTf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 3 Feb 2020 06:19:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49326 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728001AbgBCLTe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Feb 2020 06:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580728773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=493k9Og39jtWiLndCQOoMUK2JSSDBJfJ4zw0J4ayoBY=;
        b=ZT3vMjRD78mPy1tnFaq3rd6DyZ+djmK0lbVe/jZ2JyBJX2Qd8E2w1INVM9rvkAIiGDX3d8
        igK+8L2xmuMIXSSzhJzN0C7fdGqhS62POWZjnalKigi5PqzaAOmvyblOGv8IOSfHhLaReJ
        ceQGAfDA5lV1ChTGjjDexjQ6EH1ncb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-6yJ_6DP5OA-NR0p6Koav4Q-1; Mon, 03 Feb 2020 06:19:29 -0500
X-MC-Unique: 6yJ_6DP5OA-NR0p6Koav4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E52A98017CC;
        Mon,  3 Feb 2020 11:19:27 +0000 (UTC)
Received: from gondolin (ovpn-117-79.ams2.redhat.com [10.36.117.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15A6760BE0;
        Mon,  3 Feb 2020 11:19:23 +0000 (UTC)
Date:   Mon, 3 Feb 2020 12:19:21 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, david@redhat.com
Subject: Re: [kvm-unit-tests PATCH v5 3/7] s390x: Stop the cpu that is
 executing exit()
Message-ID: <20200203121921.2999fee9.cohuck@redhat.com>
In-Reply-To: <20200201152851.82867-4-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
        <20200201152851.82867-4-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat,  1 Feb 2020 10:28:47 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> CPU 0 is not necessarily the CPU which does the exit if we ran into a
> test abort situation. So, let's ask stap() which cpu does the exit and
> stop it on exit.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

