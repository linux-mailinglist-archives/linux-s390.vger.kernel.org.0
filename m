Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A0DFD1ED
	for <lists+linux-s390@lfdr.de>; Fri, 15 Nov 2019 01:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKOA0X (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Nov 2019 19:26:23 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:46986 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKOA0X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 19:26:23 -0500
Received: by mail-qt1-f170.google.com with SMTP id r20so8886229qtp.13
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0tFAznP/o2VP74kg2CnbkybxNqllPHihT5bPzStJDZw=;
        b=gHpgVYE7BklA5dff+/FV7O0g+fRSURY17JLB+bDgYYI/ULYrMLGXLVtkDm3WaUmTzW
         3BJWsOf0KeIsLbFLz7WeJMYhF3EoWf2p5sGlaWaImptYaHx+nD/npZxIZ2bbxnuB9/Q7
         VnVasKuq9iGMAPrU2lcqF4mtbvEuwO4uOQ7wC5WEeh7f8fbVwVCpPdvFAt5SG9Ve9wPz
         6AGaX5Y17XDcMMX+gVtHiXtYgWY3eTueQ7KH+hbbz/pYkaf7+9vKm5LZLloba606odtZ
         bQY1BV7qU/IkcjkJ22KjAK66OwybBtbHJukxQ4pH6mbHCY7ywayi02S7CbKQ981R0aTM
         Vh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0tFAznP/o2VP74kg2CnbkybxNqllPHihT5bPzStJDZw=;
        b=Q2+vtOoLF4XY7vpQV5S0Kp1DvA1cSaC+Z/RpvENOMyHeJeOi9ZcQ3g54UWkG4MJz7S
         8S+I/a4hPLcDlIWEnu9oVa7KCcbqzY9osCUugVTU+ZqSHQwS2lqvcQVcHEuk08VBHDW1
         PIZPVVm74iSj0U87Ms3x7IaEyWJDzGN0Zls8lE/b0//Y5f0N4gNBZ8H1S7bknw5cvdfg
         KYD2JRhgQ0DF0zJ+CMh2snhSd/7uU+ziUxqhIkSTLdKgBoO6r/moDgdSmNZhRRdN5Ape
         iwfMnjAoyXC4QvbN/1QpW1PswV8oBav/4HTpJ4i2raz869YLF/S7ejZtUpDW2YTOqzPA
         NQcA==
X-Gm-Message-State: APjAAAU8nPl4kHV3o2ya3gToGsgP/q8gs8x4qhqH0132y0GOWCYfLHv2
        04Pv1yN2aYjzf7wuNp24WLlBpQ==
X-Google-Smtp-Source: APXvYqyPWcdxmbDJkLh4PF4RYWC5w7LaBpYgd9hxKsutZWpQWgJEpJsKfIh6RuJQ4NDIuohgyYqCpA==
X-Received: by 2002:aed:3fc4:: with SMTP id w4mr11497978qth.120.1573777582450;
        Thu, 14 Nov 2019 16:26:22 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q8sm4302888qta.31.2019.11.14.16.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 16:26:21 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
Date:   Thu, 14 Nov 2019 19:26:21 -0500
Message-Id: <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
In-Reply-To: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> Acked-by: Tejun Heo <tj@kernel.org>

Tejun, suppose you will take this patch via your tree together with the seri=
es or should I Cc Andrew who normally handle this file?=
